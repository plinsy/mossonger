class Space < ApplicationRecord
  belongs_to :admin, class_name: "User"
  has_many :aliens, dependent: :destroy
end
