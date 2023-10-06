# spec/models/order_spec.rb

require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "validations" do
    it "is not valid without a client_name" do
      order = Order.new(client_name: nil, shipping: 10.50, product_id: 1)
      expect(order).not_to be_valid
      expect(order.errors[:client_name]).to include("can't be blank")
    end

    it "is not valid without a shipping" do
      order = Order.new(client_name: "John Doe", shipping: nil, product_id: 1)
      expect(order).not_to be_valid
      expect(order.errors[:shipping]).to include("can't be blank")
    end

    it "is not valid without a product_id" do
      order = Order.new(client_name: "John Doe", shipping: 10.50, product_id: nil)
      expect(order).not_to be_valid
      expect(order.errors[:product_id]).to include("can't be blank")
    end

    it "is valid with all attributes present" do
      store = Store.create(name: "Store Name", description: "Store Description")
      product = Product.create(name: "Product Name", price: 10.0, stock: 5, sku: "SKU123", store_id: store.id)
      order = Order.new(client_name: "John Doe", shipping: 10.50, product_id: product.id)
      expect(order).to be_valid
    end
  end

  describe "database" do
    it "can save a valid order" do
      store = Store.create(name: "Store Name", description: "Store Description")
      product = Product.create(name: "Product Name", price: 10.0, stock: 5, sku: "SKU123", store_id: store.id)
      order = Order.new(client_name: "John Doe", shipping: 10.50, product_id: product.id)
      expect(order.save).to be true
    end

    it "cannot save an invalid order" do
      store = Store.create(name: "Store Name", description: "Store Description")
      product = Product.create(name: "Product Name", price: 10.0, stock: 5, sku: "SKU123", store_id: store.id)
      order = Order.new(client_name: nil, shipping: 10.50, product_id: product.id)
      expect(order.save).to be false
    end
  end
end
