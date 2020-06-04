class ApplicationRecord < ActiveRecord::Base
	include Rails.application.routes.url_helpers
  self.abstract_class = true

  def dropped?
  	Trash.where(trashable: self).any?
  end
end
