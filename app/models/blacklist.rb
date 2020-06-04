class Blacklist < ApplicationRecord
  belongs_to :admin, class_name: "User"
  has_many :condemneds, dependent: :destroy
end
