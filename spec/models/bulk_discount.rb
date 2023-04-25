require 'rails_helper'

RSpec.describe BulkDiscount do
  
  describe "relationships" do
    it {should belong_to :merchant}
  end
  before :each do
    test_data
  end
  describe "#instance methods" do
    describe "#discount_calculator" do
      it 'discount calculator' do
          expect(@bulk_discount_1.discount_calculator).to eq(0.9)
          expect(@bulk_discount_2.discount_calculator).to eq(0.8)
          expect(@bulk_discount_3.discount_calculator).to eq(0.7)
          expect(@bulk_discount_4.discount_calculator).to eq(0.6)
        end
      end
    end
  end