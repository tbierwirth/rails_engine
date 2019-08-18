class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :merchant_id, :description, :name
  attribute :unit_price do |object|
    '%.2f' % (object.unit_price.to_f / 100)
  end
end
