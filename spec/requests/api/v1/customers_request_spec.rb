require 'rails_helper'

describe 'Customers API Endpoints' do
  before :each do
    @customer_1 = FactoryBot.create(:customer, created_at: Date.today, updated_at: Date.today)
    @customer_2 = FactoryBot.create(:customer)
    @customer_3 = FactoryBot.create(:customer)
    @merchant = Merchant.create!(name: "Bob's Burgers")
    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, merchant_id: @merchant.id, status: 'shipped')
    @invoice_2 = Invoice.create!(customer_id: @customer_1.id, merchant_id: @merchant.id, status: 'shipped')
    @invoice_3 = Invoice.create!(customer_id: @customer_2.id, merchant_id: @merchant.id, status: 'shipped')
    @transaction_1 = FactoryBot.create(:transaction, invoice_id: @invoice_1.id)
    @transaction_2 = FactoryBot.create(:transaction, invoice_id: @invoice_1.id)
    @transaction_3 = FactoryBot.create(:transaction, invoice_id: @invoice_1.id)
  end

  it 'sends a list of customers' do
    get '/api/v1/customers'

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers["data"].count).to eq(3)
  end

  it "can get one customer by its id" do
    id = create(:customer).id

    get "/api/v1/customers/#{id}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["data"]["id"].to_i).to eq(id)
  end

  it "can find a customer with query first_name parameters" do
    get "/api/v1/customers/find?first_name=#{@customer_1.first_name}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["data"]["attributes"]["id"]).to eq(@customer_1.id)
  end

  it "can find a customer with query last_name parameters" do
    get "/api/v1/customers/find?last_name=#{@customer_1.last_name}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["data"]["attributes"]["id"]).to eq(@customer_1.id)
  end

  it "can find a customer with query created_at parameters" do
    get "/api/v1/customers/find?created_at=#{Date.today}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["data"]["id"]).to eq(@customer_1.id.to_s)
  end

  it "can find a customer with query updated_at parameters" do
    get "/api/v1/customers/find?updated_at=#{Date.today}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["data"]["id"]).to eq(@customer_1.id.to_s)
  end

  it "can find all customers by id" do
    get "/api/v1/customers/find_all?id=#{@customer_1.id}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["data"].first["id"]).to eq(@customer_1.id.to_s)
  end

  it "can find all customers by first name" do
    get "/api/v1/customers/find_all?first_name=#{@customer_2.first_name}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["data"].first["attributes"]["id"]).to eq(@customer_2.id)
  end

  it "can find all customers by last name" do
    get "/api/v1/customers/find_all?last_name=#{@customer_2.last_name}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["data"].first["attributes"]["id"]).to eq(@customer_2.id)
  end

  it "can find all customers by created_at" do
    get "/api/v1/customers/find_all?created_at=#{Date.today}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["data"].first["attributes"]["id"]).to eq(@customer_1.id)
  end

  it "can return all invoices associated with a customer" do
    get "/api/v1/customers/#{@customer_1.id}/invoices"

    invoices = JSON.parse(response.body)

    expect(response).to be_successful

    expect(invoices["data"].first["attributes"]["id"]).to eq(@invoice_1.id)
    expect(invoices["data"].last["attributes"]["id"]).to eq(@invoice_2.id)
  end

  it "can return all transactions associated with a customer" do
    get "/api/v1/customers/#{@customer_1.id}/transactions"

    transactions = JSON.parse(response.body)

    expect(response).to be_successful

    expect(transactions["data"].first["attributes"]["id"]).to eq(@transaction_1.id)
    expect(transactions["data"].last["attributes"]["id"]).to eq(@transaction_3.id)
  end

end
