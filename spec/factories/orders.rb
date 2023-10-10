# Factory for Order model
FactoryBot.define do
  factory :order do
    client_name { "John Doe" }
    shipping { 5 }
    association :product, factory: :product
    store { create(:store) }
  end
end
