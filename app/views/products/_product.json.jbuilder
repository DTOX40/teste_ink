json.extract! product, :id, :name, :price, :stock, :sku, :store_id, :created_at, :updated_at
json.url product_url(product, format: :json)
