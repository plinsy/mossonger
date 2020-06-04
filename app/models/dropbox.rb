class Dropbox < ApplicationRecord
  belongs_to :admin, class_name: "User"
  has_many :trashes, dependent: :destroy
end
