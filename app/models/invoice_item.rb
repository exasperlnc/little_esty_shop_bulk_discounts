class InvoiceItem < ApplicationRecord
  validates_presence_of :invoice_id,
                        :item_id,
                        :quantity,
                        :unit_price,
                        :status

  belongs_to :invoice
  belongs_to :item

  enum status: [:pending, :packaged, :shipped]

  def self.incomplete_invoices
    invoice_ids = InvoiceItem.where("status = 0 OR status = 1").pluck(:invoice_id)
    Invoice.order(created_at: :asc).find(invoice_ids)
  end

  def add_bulk_discount(bulk_discount_id)
    update_columns(bulk_discount_id: bulk_discount_id)
  end

  def top_discount
    item
    .merchant
    .bulk_discounts
    .where("quantity_threshold <= '#{self.quantity}'")
    .order('percentage_discount DESC')
    .first
  end
end
