FactoryBot.define do
  factory :transaction do
    credit_card_number { 10.times.map{rand(10)}.join }
    result { "success" }
  end
end
