class Reading < ApplicationRecord
  belongs_to :user
  belongs_to :conversation
  belongs_to :message
end
