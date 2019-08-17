class InvoiceSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :merchant_id, :customer_id, :status

  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items
  has_many :transactions
  has_many :items, through: :invoice_items
end
