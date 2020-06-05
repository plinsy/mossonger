class Space < ApplicationRecord
  belongs_to :admin, class_name: "User"
  has_many :aliens, dependent: :destroy

  def mute(muteable)
  	alien = self.aliens.where(muteable: muteable).any? ? self.aliens.find_by(muteable: muteable).delete : self.aliens.create(muteable: muteable)
  end
end
