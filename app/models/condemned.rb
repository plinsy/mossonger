class Condemned < ApplicationRecord
  belongs_to :blacklist
  belongs_to :blockable, polymorphic: true
end
