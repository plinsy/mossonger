class Alien < ApplicationRecord
  belongs_to :space
  belongs_to :muteable, polymorphic: true
end
