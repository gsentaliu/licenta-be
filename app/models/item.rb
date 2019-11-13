class Item < ApplicationRecord
  # model association
  belongs_to :exam

  # validation
  validates_presence_of :name
end
