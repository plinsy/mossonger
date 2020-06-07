class Dropbox < ApplicationRecord
  belongs_to :admin, class_name: "User"
  has_many :trashes, dependent: :destroy

  def drop(dropable)
  	trash = self.trashes.new(trashable: dropable)
  	return trash.save
  end

  def conversations
  	trashes.where(trashable_type: 'Conversation').map { |t| t.trashable }
  end
end
