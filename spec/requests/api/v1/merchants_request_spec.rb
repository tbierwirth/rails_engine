require 'rails_helper'

describe 'Merchants API Endpoints' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Bob's Burgers", created_at: Date.today.last_week, updated_at: Date.today.last_week)
    @merchant_2 = Merchant.create!(name: "Ted's Tacos", created_at: Date.today, updated_at: Date.today)
    @merchant_3 = Merchant.create!(name: "Ben's Beans", created_at: Date.today, updated_at: Date.today)
  end

  it 'sends a list of merchants' do
    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(3)
  end

  it "can get one merchant my its id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"]["id"].to_i).to eq(id)
  end

  it "can find a merchant with query name parameters" do
    name = create(:merchant).name

    get "/api/v1/merchants/find?name=#{name}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"]["attributes"]["name"]).to eq(name)
  end

  it "can find a merchant with query created_at parameters" do
    merchant_1 = Merchant.create!(name: "Bob's Burgers", created_at: Date.today.last_week, updated_at: Date.today.last_week)
    merchant_2 = Merchant.create!(name: "Ted's Tacos", created_at: Date.today)

    get "/api/v1/merchants/find?created_at=#{@merchant_1.created_at}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"]["id"]).to eq(@merchant_1.id.to_s)
  end

  it "can find a merchant with query updated_at parameters" do
    get "/api/v1/merchants/find?updated_at=#{@merchant_2.updated_at}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"]["id"]).to eq(@merchant_2.id.to_s)
  end

  it "can find all merchants by id" do
    get "/api/v1/merchants/find_all?id=#{@merchant_1.id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"].first["id"]).to eq(@merchant_1.id.to_s)
  end

  it "can find all merchants by name" do
    get "/api/v1/merchants/find_all?name=#{@merchant_2.name}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"].first["attributes"]["name"]).to eq(@merchant_2.name)
  end

  it "can find all merchants by created_at" do
    get "/api/v1/merchants/find_all?created_at=#{Date.today}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"].first["attributes"]["name"]).to eq(@merchant_2.name)
    expect(merchant["data"].last["attributes"]["name"]).to eq(@merchant_3.name)
  end

  it "can return all items associated with a merchant" do
    item_1 = FactoryBot.create(:item, merchant_id: @merchant_2.id)
    item_2 = FactoryBot.create(:item, merchant_id: @merchant_2.id)
    item_3 = FactoryBot.create(:item, merchant_id: @merchant_2.id)

    get "/api/v1/merchants/#{@merchant_2.id}/items"

    items = JSON.parse(response.body)

    expect(response).to be_successful

    expect(items["data"].first["attributes"]["name"]).to eq(item_1.name)
    expect(items["data"].second["attributes"]["name"]).to eq(item_2.name)
    expect(items["data"].last["attributes"]["name"]).to eq(item_3.name)
  end

  it "can return all invoices associated with a merchant" do
    customer = Customer.create(first_name: "Bill", last_name: "Gates")
    invoice_1 = customer.invoices.create(merchant_id: @merchant_3.id, status: "shipped")
    invoice_2 = customer.invoices.create(merchant_id: @merchant_3.id, status: "shipped")
    invoice_3 = customer.invoices.create(merchant_id: @merchant_3.id, status: "shipped")
    invoice_4 = customer.invoices.create(merchant_id: @merchant_2.id, status: "shipped")

    get "/api/v1/merchants/#{@merchant_3.id}/invoices"

    invoices = JSON.parse(response.body)

    expect(response).to be_successful

    expect(invoices["data"].first["attributes"]["id"]).to eq(invoice_1.id)
    expect(invoices["data"].last["attributes"]["id"]).to eq(invoice_3.id)
  end

end
