class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  validates :name, presence: true
  validates :percentage_discount, presence: true
  validates :quantity_threshold, presence: true

  def discount_calculator
    1 - (percentage_discount.to_f / 100)
  end
end