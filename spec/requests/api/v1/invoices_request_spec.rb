require 'rails_helper'

describe 'InvoiceSerializer API' do
  before :each do
    @customer = Customer.create!(name: "Bill Gates")
    @merchant = Merchant.create!(name: "Bob's Burgers", created_at: Date.today.last_week, updated_at: Date.today.last_week)
    @invoice_1 = Invoice.create!(customer_id: customer.id, merchant_id: merchant_1.id, status: 'shipped')
    @invoice_2 = Invoice.create!(customer_id: customer.id, merchant_id: merchant_1.id, status: 'shipped')
    @invoice_3 = Invoice.create!(customer_id: customer.id, merchant_id: merchant_1.id, status: 'shipped')
  end

  it 'sends a list of merchants' do
    get '/api/v1/invoices'

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices["data"].count).to eq(3)
  end

  it "can get one invoice my its id" do
    get "/api/v1/invoices/#{@invoice_2.id}"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["data"]["id"].to_i).to eq(@invoice_2.id)
  end

  it "can find a invoice with query customer_id parameters" do
    get "/api/v1/invoices/find?customer_id=#{@customer.id}"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["data"]["attributes"]["customer_id"]).to eq(@customer.id)
  end

  it "can find a invoice with query merchant_id parameters" do
    get "/api/v1/invoices/find?merchant_id=#{@merchant.id}"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["data"]["attributes"]["merchant_id"]).to eq(@merchant.id)
  end

  it "can find a invoice with query created_at parameters" do
    get "/api/v1/invoices/find?created_at=#{@invoice_3.created_at}"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["data"]["id"]).to eq(@invoice_3.id.to_s)
  end

  it "can find a invoice with query updated_at parameters" do
    get "/api/v1/invoices/find?updated_at=#{@invoice_2.updated_at}"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["data"]["id"]).to eq(@invoice_2.id.to_s)
  end

  it "can find all invoices by id" do
    get "/api/v1/invoices/find_all?id=#{@invoice_1.id}"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["data"].first["id"]).to eq(@invoice_1.id.to_s)
  end

  it "can find all invoices by status" do
    get "/api/v1/invoices/find_all?status=shipped"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["data"].first["attributes"]["status"]).to eq(@invoice_1.status)
    expect(invoice["data"].last["attributes"]["status"]).to eq(@invoice_3.status)
  end

  it "can find all invoices by created_at" do
    get "/api/v1/invoices/find_all?created_at=#{Date.today}"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["data"].first["attributes"]["id"]).to eq(@invoice_1.id)
    expect(invoice["data"].last["attributes"]["id"]).to eq(@invoice_3.id)
  end

  it "can return all transactions associated with an invoice" do
    get "/api/v1/invoices/#{@invoice_1.id}/transactions"

    transactions = JSON.parse(response.body)

    expect(response).to be_successful

    expect(transactions["data"].first["attributes"]["id"]).to eq(transaction_1.id)
    expect(transactions["data"].second["attributes"]["id"]).to eq(transaction_2.id)
    expect(transactions["data"].last["attributes"]["id"]).to eq(transaction_3.id)
  end

  it "can return all invoice_items associated with an invoice" do
    get "/api/v1/invoices/#{@invoice_1.id}/invoice_items"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_successful

    expect(invoice_items["data"].first["attributes"]["id"]).to eq(invoice_item_1.id)
    expect(invoice_items["data"].last["attributes"]["id"]).to eq(invoice_item_3.id)
  end

  it "can return all items associated with an invoice" do
    get "/api/v1/invoices/#{@invoice_1.id}/items"

    items = JSON.parse(response.body)

    expect(response).to be_successful

    expect(items["data"].first["attributes"]["id"]).to eq(item_1.id)
    expect(items["data"].last["attributes"]["id"]).to eq(item_3.id)
  end

end
