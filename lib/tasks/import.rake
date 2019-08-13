require 'csv'

namespace :import do

  desc "All"
  task all: [:merchants, :items, :customers, :invoices, :invoice_items, :transactions]

  desc "Import data individually from CSV file"

  task merchants: :environment do
    merchants = []
    CSV.foreach('./db/data/merchants.csv', headers: true) do |row|
      merchants << row.to_h
    end
    Merchant.import(merchants)
  end

  task items: :environment do
    items = []
    CSV.foreach('./db/data/items.csv', headers: true) do |row|
      items << row.to_h
    end
    Item.import(items)
  end

  task customers: :environment do
    customers = []
    CSV.foreach('./db/data/customers.csv', headers: true) do |row|
      customers << row.to_h
    end
    Customer.import(customers)
  end

  task invoices: :environment do
    invoices = []
    CSV.foreach('./db/data/invoices.csv', headers: true) do |row|
      invoices << row.to_h
    end
    Invoice.import(invoices)
  end

  task invoice_items: :environment do
    invoice_items = []
    CSV.foreach('./db/data/invoice_items.csv', headers: true) do |row|
      invoice_items << row.to_h
    end
    InvoiceItem.import(invoice_items)
  end

  task transactions: :environment do
    transactions = []
    CSV.foreach('./db/data/transactions.csv', headers: true) do |row|
      transactions << row.to_h
    end
    Transaction.import(transactions)
  end

end
