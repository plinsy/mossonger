class Nickname < ApplicationRecord
  belongs_to :conversation
  belongs_to :user
  before_validation :add_name
  def add_name
  	if ["", nil].include?self.name
  		self.name = self.user.name
  	end
  end
end
