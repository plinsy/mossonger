class ApplicationRecord < ActiveRecord::Base
	include Rails.application.routes.url_helpers
  self.abstract_class = true

  def dropped?
  	Trash.where(trashable: self).any?
  end

  def dropped_at
  	Trash.where(trashable: self).first.created_at
  end

  def dropper
  	T
  end
end
