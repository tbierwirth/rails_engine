require 'rails_helper'

describe 'Invoice Items API Endpoints' do
  before :each do
    @customer = Customer.create!(first_name: "Bill", last_name: "Gates")
    @merchant = Merchant.create!(name: "Bob's Burgers", created_at: Date.today.last_week, updated_at: Date.today.last_week)
    @item_1 = FactoryBot.create(:item, merchant_id: @merchant.id)
    @item_2 = FactoryBot.create(:item, merchant_id: @merchant.id)
    @item_3 = FactoryBot.create(:item, merchant_id: @merchant.id)
    @invoice_1 = Invoice.create!(customer_id: @customer.id, merchant_id: @merchant.id, status: 'shipped', created_at: Date.today.last_week, updated_at: Date.today.last_week)
    @invoice_2 = Invoice.create!(customer_id: @customer.id, merchant_id: @merchant.id, status: 'shipped', created_at: Date.today, updated_at: Date.today)
    @invoice_3 = Invoice.create!(customer_id: @customer.id, merchant_id: @merchant.id, status: 'shipped', created_at: Date.today, updated_at: Date.today)
    @transaction_1 = FactoryBot.create(:transaction, invoice_id: @invoice_1.id)
    @transaction_2 = FactoryBot.create(:transaction, invoice_id: @invoice_1.id)
    @transaction_3 = FactoryBot.create(:transaction, invoice_id: @invoice_1.id)
    @invoice_item = FactoryBot.create(:invoice_item, item_id: @item_3.id, invoice_id: @invoice_1.id, unit_price: @item_3.unit_price, created_at: Date.today.last_week, updated_at: Date.today.last_week)
    10.times { FactoryBot.create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_2.id, unit_price: @item_1.unit_price, created_at: Date.today, updated_at: Date.today) }
    5.times { FactoryBot.create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_2.id, unit_price: @item_1.unit_price, created_at: Date.today, updated_at: Date.today) }
  end

  it 'can get a list of invoice items' do
    get '/api/v1/invoice_items'

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items["data"].count).to eq(16)
  end

  it "can get one invoice item by its id" do
    get "/api/v1/invoice_items/#{@invoice_item.id}"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_items["data"]["id"].to_i).to eq(@invoice_item.id)
  end

  it "can get one random invoice item" do
    get "/api/v1/invoice_items/random"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(InvoiceItem.where(id: invoice_items["data"]["id"].to_i)).to exist
  end

  it "can find a invoice item with query item_id parameters" do
    get "/api/v1/invoice_items/find?item_id=#{@item_3.id}"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_items["data"]["attributes"]["id"]).to eq(@invoice_item.id)
  end

  it "can find a invoice item with query invoice_id parameters" do
    get "/api/v1/invoice_items/find?invoice_id=#{@invoice_1.id}"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_items["data"]["attributes"]["id"]).to eq(@invoice_item.id)
  end

  it "can find a invoice item with query quantity parameters" do
    get "/api/v1/invoice_items/find?quantity=#{@invoice_item.quantity}"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_items["data"]["attributes"]["id"]).to eq(@invoice_item.id)
  end

  it "can find a invoice item with query unit_price parameters" do
    get "/api/v1/invoice_items/find?unit_price=#{(@invoice_item.unit_price.to_f)/100}"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_items["data"]["attributes"]["id"]).to eq(@invoice_item.id)
  end

  it "can find a invoice item with query created_at parameters" do
    get "/api/v1/invoice_items/find?created_at=#{Date.today.last_week}"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_items["data"]["id"]).to eq(@invoice_item.id.to_s)
  end

  it "can find a invoice item with query updated_at parameters" do
    get "/api/v1/invoice_items/find?updated_at=#{@invoice_item.updated_at}"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_items["data"]["id"]).to eq(@invoice_item.id.to_s)
  end

  it "can find all invoice_items by id" do
    get "/api/v1/invoice_items/find_all?id=#{@invoice_item.id}"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_items["data"].first["id"]).to eq(@invoice_item.id.to_s)
  end

  it "can find all invoice_items by unit_price" do
    get "/api/v1/invoice_items/find_all?unit_price=#{(@item_1.unit_price.to_f)/100}"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_items["data"].count).to eq(15)
  end

  it "can find all invoice_items by created_at" do
    get "/api/v1/invoice_items/find_all?created_at=#{Date.today}"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_items["data"].count).to eq(15)
  end

  it "can return the associated invoice" do
    get "/api/v1/invoice_items/#{@invoice_item.id}/invoice"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["data"]["attributes"]["id"]).to eq(@invoice_1.id)
  end

  it "can return the associated item" do
    get "/api/v1/invoice_items/#{@invoice_item.id}/item"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["attributes"]["id"]).to eq(@item_3.id)
  end

end
