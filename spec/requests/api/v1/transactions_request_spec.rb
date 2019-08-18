require 'rails_helper'

describe 'Transactions API Endpoints' do
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
    @transaction_2 = FactoryBot.create(:transaction, invoice_id: @invoice_2.id)
    @transaction_3 = FactoryBot.create(:transaction, invoice_id: @invoice_3.id, result: 'failed', created_at: Date.today, updated_at: Date.today)
    @invoice_item = FactoryBot.create(:invoice_item, item_id: @item_3.id, invoice_id: @invoice_1.id, unit_price: @item_3.unit_price, created_at: Date.today.last_week, updated_at: Date.today.last_week)
    10.times { FactoryBot.create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_2.id, unit_price: @item_1.unit_price, created_at: Date.today, updated_at: Date.today) }
    5.times { FactoryBot.create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_2.id, unit_price: @item_1.unit_price, created_at: Date.today, updated_at: Date.today) }
  end

  it 'can get a list of transactions' do
    get '/api/v1/transactions'

    expect(response).to be_successful

    transactions = JSON.parse(response.body)

    expect(transactions["data"].count).to eq(3)
  end

  it "can get one transaction by its id" do
    get "/api/v1/transactions/#{@transaction_1.id}"

    transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction["data"]["id"].to_i).to eq(@transaction_1.id)
  end

  it "can get one random transaction" do
    get "/api/v1/transactions/random"

    transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(Transaction.where(id: transaction["data"]["id"].to_i)).to exist
  end

  it "can find a transaction with query invoice_id parameters" do
    get "/api/v1/transactions/find?invoice_id=#{@invoice_1.id}"

    transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction["data"]["attributes"]["id"]).to eq(@transaction_1.id)
  end

  it "can find a transaction with query credit_card_number parameters" do
    get "/api/v1/transactions/find?credit_card_number=#{@transaction_1.credit_card_number}"

    transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction["data"]["attributes"]["id"]).to eq(@transaction_1.id)
  end

  it "can find a transaction with query result parameters" do
    get "/api/v1/transactions/find?result=#{@transaction_1.result}"

    transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction["data"]["attributes"]["id"]).to eq(@transaction_1.id)
  end

  it "can find a transaction with query created_at parameters" do
    get "/api/v1/transactions/find?created_at=#{Date.today}"

    transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction["data"]["id"]).to eq(@transaction_3.id.to_s)
  end

  it "can find a transaction with query updated_at parameters" do
    get "/api/v1/transactions/find?updated_at=#{Date.today}"

    transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction["data"]["id"]).to eq(@transaction_3.id.to_s)
  end

  it "can find all transactions by id" do
    get "/api/v1/transactions/find_all?id=#{@transaction_1.id}"

    transactions = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transactions["data"].first["id"]).to eq(@transaction_1.id.to_s)
  end

  it "can find all transactions by credit_card_number" do
    get "/api/v1/transactions/find_all?credit_card_number=#{@transaction_1.credit_card_number}"

    transactions = JSON.parse(response.body)

    expect(response).to be_successful

    expect(transactions["data"].first["id"]).to eq(@transaction_1.id.to_s)
  end

  it "can find all transactions by result" do
    get "/api/v1/transactions/find_all?result=failed"

    transactions = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transactions["data"].first["id"]).to eq(@transaction_3.id.to_s)
  end

  it "can find all transactions by created_at" do
    get "/api/v1/transactions/find_all?created_at=#{Date.today}"

    transactions = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transactions["data"].count).to eq(1)
    expect(transactions["data"].first["id"]).to eq(@transaction_3.id.to_s)
  end

  it "can return the associated invoice" do
    get "/api/v1/transactions/#{@transaction_1.id}/invoice"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["data"]["attributes"]["id"]).to eq(@invoice_1.id)
  end

end
