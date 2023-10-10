# Factory for Product model
FactoryBot.define do
  factory :product do
    name { "Product Name" }
    price { 10.0 }
    stock { 10 }
    sku { "SKU-123" }
    association :store, factory: :store
  end
end
