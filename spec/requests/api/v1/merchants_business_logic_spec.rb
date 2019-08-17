require 'rails_helper'

describe 'Merchants API Business Logic' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Bob's Burgers", created_at: Date.today.last_week, updated_at: Date.today.last_week)
    @merchant_2 = Merchant.create!(name: "Ted's Tacos", created_at: Date.today, updated_at: Date.today)
    @merchant_3 = Merchant.create!(name: "Ben's Beans", created_at: Date.today, updated_at: Date.today)
  end

  it "can return the top x merchants ranked by total revenue" do
    customer = Customer.create(first_name: "Bill", last_name: "Gates")
    item_1 = FactoryBot.create(:item, merchant_id: @merchant_2.id)
    item_2 = FactoryBot.create(:item, merchant_id: @merchant_2.id)
    item_3 = FactoryBot.create(:item, merchant_id: @merchant_3.id)
    invoice_1 = FactoryBot.create(:invoice, merchant_id: @merchant_2.id, customer_id: customer.id)
    invoice_2 = FactoryBot.create(:invoice, merchant_id: @merchant_3.id, customer_id: customer.id)
    FactoryBot.create(:transaction, invoice_id: invoice_1.id)
    FactoryBot.create(:transaction, invoice_id: invoice_2.id)
    10.times { FactoryBot.create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, unit_price: item_1.unit_price) }
    10.times { FactoryBot.create(:invoice_item, item_id: item_2.id, invoice_id: invoice_1.id, unit_price: item_2.unit_price) }
    2.times { FactoryBot.create(:invoice_item, item_id: item_3.id, invoice_id: invoice_2.id, unit_price: item_3.unit_price) }

    get "/api/v1/merchants/most_revenue?quantity=5"

    merchants = JSON.parse(response.body)

    expect(merchants["data"].first["attributes"]["name"]).to eq(@merchant_2.name)
    expect(merchants["data"].last["attributes"]["name"]).to eq(@merchant_3.name)
  end

  it "can return the top x merchants ranked by total items sold" do
    customer = Customer.create(first_name: "Bill", last_name: "Gates")
    item_1 = FactoryBot.create(:item, merchant_id: @merchant_2.id)
    item_2 = FactoryBot.create(:item, merchant_id: @merchant_1.id)
    invoice_1 = FactoryBot.create(:invoice, merchant_id: @merchant_2.id, customer_id: customer.id)
    invoice_2 = FactoryBot.create(:invoice, merchant_id: @merchant_1.id, customer_id: customer.id)
    FactoryBot.create(:transaction, invoice_id: invoice_1.id)
    FactoryBot.create(:transaction, invoice_id: invoice_2.id)
    20.times { FactoryBot.create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, unit_price: item_1.unit_price) }
    2.times { FactoryBot.create(:invoice_item, item_id: item_2.id, invoice_id: invoice_2.id, unit_price: item_2.unit_price) }

    get "/api/v1/merchants/most_items?quantity=5"

    merchants = JSON.parse(response.body)

    expect(merchants["data"].first["attributes"]["name"]).to eq(@merchant_2.name)
    expect(merchants["data"].last["attributes"]["name"]).to eq(@merchant_1.name)
  end

end
