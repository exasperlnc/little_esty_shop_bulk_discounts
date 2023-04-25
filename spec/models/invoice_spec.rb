require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "validations" do
    it { should validate_presence_of :status }
    it { should validate_presence_of :customer_id }
  end
  describe "relationships" do
    it { should belong_to :customer }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should have_many :transactions}
  end
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
    @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
    @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
    @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 2)
    @ii_11 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 1, unit_price: 10, status: 1)

    @bd_1 = @merchant1.bulk_discounts.create(name: "10% for 5", quantity_threshold: 5, percentage_discount: 10)
    @bd_2 = @merchant1.bulk_discounts.create(name: "15% for 8", quantity_threshold: 8, percentage_discount: 15)
    @bd_3 = @merchant1.bulk_discounts.create(name: "30% for 10", quantity_threshold: 10, percentage_discount: 30)
    @bd_4 = @merchant1.bulk_discounts.create(name: "50% for 10", quantity_threshold: 10, percentage_discount: 50)
    @bd_5 = @merchant1.bulk_discounts.create(name: "60% for 15", quantity_threshold: 15, percentage_discount: 60)
  end
  describe "instance methods" do
    it "total_revenue" do
      expect(@invoice_1.total_revenue).to eq(100)
    end

    it 'total_discounted_revenue' do
      expect(@invoice_1.total_discounted_revenue).to eq(86.5)
    end
  end
end
