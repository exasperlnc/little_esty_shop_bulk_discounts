class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: [:cancelled, 'in progress', :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def total_discounted_revenue
    total = 0
    #each ii
      #check for BD -- ii.merchant.highest_qualifying_discount(ii.quantity)
        #if above method.nil?
          total += (ii.unit_price * ii.quantity)
        #else
          total += ((ii.unit_price * ii.quantity) * #line_20.discount_calculator)
        #end
    total
  end
end
