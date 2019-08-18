class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :invoice_id, :item_id, :quantity
  attribute :unit_price do |object|
    '%.2f' % (object.unit_price.to_f / 100)
  end
end
