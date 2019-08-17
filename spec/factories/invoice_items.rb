FactoryBot.define do
  factory :invoice_item do
    quantity { rand(1..20).to_s }
  end
end
