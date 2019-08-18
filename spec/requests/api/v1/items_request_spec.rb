require 'rails_helper'

describe 'Invoices API Endpoints' do
  before :each do
    @customer = Customer.create!(first_name: "Bill", last_name: "Gates")
    @merchant = Merchant.create!(name: "Bob's Burgers", created_at: Date.today.last_week, updated_at: Date.today.last_week)
    @item_1 = FactoryBot.create(:item, merchant_id: @merchant.id)
    @item_2 = FactoryBot.create(:item, merchant_id: @merchant.id, created_at: Date.today, updated_at: Date.today)
    @item_3 = FactoryBot.create(:item, merchant_id: @merchant.id, created_at: Date.today, updated_at: Date.today)
    @invoice_1 = Invoice.create!(customer_id: @customer.id, merchant_id: @merchant.id, status: 'shipped', created_at: Date.today.last_week, updated_at: Date.today.last_week)
    @invoice_2 = Invoice.create!(customer_id: @customer.id, merchant_id: @merchant.id, status: 'shipped', created_at: Date.today, updated_at: Date.today)
    @invoice_3 = Invoice.create!(customer_id: @customer.id, merchant_id: @merchant.id, status: 'shipped', created_at: Date.today, updated_at: Date.today)
    @invoice_item_1 = FactoryBot.create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id, unit_price: @item_1.unit_price)
    10.times { FactoryBot.create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id, unit_price: @item_1.unit_price) }
    5.times { FactoryBot.create(:invoice_item, item_id: @item_3.id, invoice_id: @invoice_1.id, unit_price: @item_3.unit_price) }
  end

  it 'can get a list of items' do
    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(3)
  end

  it "can get one item by its id" do
    get "/api/v1/items/#{@item_1.id}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["id"].to_i).to eq(@item_1.id)
  end

  it "can find a item with query merchant_id parameters" do
    get "/api/v1/items/find?merchant_id=#{@merchant.id}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["attributes"]["id"]).to eq(@item_1.id)
  end

  it "can find a item with query created_at parameters" do
    get "/api/v1/items/find?created_at=#{Date.today}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["id"]).to eq(@item_2.id.to_s)
  end

  it "can find a item with query updated_at parameters" do
    get "/api/v1/items/find?updated_at=#{Date.today}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["id"]).to eq(@item_2.id.to_s)
  end

  it "can find all items by id" do
    get "/api/v1/items/find_all?id=#{@item_1.id}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"].first["id"]).to eq(@item_1.id.to_s)
  end

  it "can find all items with query merchant_id parameters" do
    get "/api/v1/items/find_all?merchant_id=#{@merchant.id}"

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items["data"].first["attributes"]["id"]).to eq(@item_1.id)
    expect(items["data"].last["attributes"]["id"]).to eq(@item_3.id)
  end

  it "can find all items by description" do
    get "/api/v1/items/find_all?description=#{@item_1.description}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"].first["attributes"]["description"]).to eq(@item_1.description)
  end

  it "can find all items by created_at" do
    get "/api/v1/items/find_all?created_at=#{Date.today}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"].first["attributes"]["id"]).to eq(@item_2.id)
    expect(item["data"].last["attributes"]["id"]).to eq(@item_3.id)
  end

  it "can find all items by updated_at" do
    get "/api/v1/items/find_all?updated_at=#{Date.today}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"].first["attributes"]["id"]).to eq(@item_2.id)
    expect(item["data"].last["attributes"]["id"]).to eq(@item_3.id)
  end

  it "can return the associated merchant" do
    get "/api/v1/items/#{@item_1.id}/merchant"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"]["attributes"]["id"]).to eq(@merchant.id)
  end

  it "can return all associated invoice_items" do
    get "/api/v1/items/#{@item_1.id}/invoice_items"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_items["data"].count).to eq(11)
    expect(invoice_items["data"].first["attributes"]["id"]).to eq(@invoice_item_1.id)
  end

end
