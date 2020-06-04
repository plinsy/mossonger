class Friendship < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :friend, class_name: "User"
  has_many :trashes, as: :trashable
  has_many :secrets, as: :hideable
  has_many :aliens, as: :muteable
  has_many :condemneds, as: :blockable
  after_create_commit :create_a_discussion
  def create_a_discussion
  	c = self.sender.conversations.create
  	c.invitations.create(guest: self.friend, is_accepted: true)
  end
end