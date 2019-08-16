FactoryBot.define do
  factory :item do
    name { Faker::Commerce.unique.product_name }
    description { Faker::ChuckNorris.fact }
    unit_price { rand.to_s[3..6]  }
  end
end
