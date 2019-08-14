class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :merchant_id, :description, :name, :unit_price
end
