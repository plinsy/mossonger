class Secret < ApplicationRecord
  belongs_to :hiding_place
  belongs_to :hideable, polymorphic: true
end
