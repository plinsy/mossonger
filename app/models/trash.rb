class Trash < ApplicationRecord
  belongs_to :dropbox
  has_one :admin, through: :dropbox
  belongs_to :trashable, polymorphic: true
end
