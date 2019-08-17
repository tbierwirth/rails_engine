class TransactionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :invoice_id

  belongs_to :invoice
end
