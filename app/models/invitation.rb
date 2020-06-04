class Invitation < ApplicationRecord
  scope :pending, -> {where("NOT is_accepted")}
  belongs_to :conversation
    has_one :sender, class_name: "User", through: :conversation, source: :admin
  belongs_to :guest, class_name: "User"
  def is_for_a_dialog?
  	return self.conversation.is_a_dialog?
  end
  after_create_commit :add_dependances
  def add_dependances
  	self.conversation.nicknames.create(user: self.guest)
  end
  def is_not_accepted
  	!self.is_accepted
  end
end
