class Bulkdiscount < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :percentage
  validates_presence_of :threshold, numericality: true
  validates_numericality_of :percentage, less_than_or_equal_to: 100
  validates_numericality_of :percentage, greater_than_or_equal_to: 1

  belongs_to :merchant

end
