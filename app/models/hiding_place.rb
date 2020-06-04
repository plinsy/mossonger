class HidingPlace < ApplicationRecord
  belongs_to :admin, class_name: "User"
  has_many :secrets, dependent: :destroy
end
