# spec/models/product_spec.rb

require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "validations" do
    it "is not valid without a name" do
      product = Product.new(name: nil, price: 10.0, stock: 5, sku: "SKU123", store_id: 1)
      expect(product).not_to be_valid
      expect(product.errors[:name]).to include("can't be blank")
    end

    it "is not valid without a price" do
      product = Product.new(name: "Product Name", price: nil, stock: 5, sku: "SKU123", store_id: 1)
      expect(product).not_to be_valid
      expect(product.errors[:price]).to include("can't be blank")
    end

    it "is not valid without a stock" do
      product = Product.new(name: "Product Name", price: 10.0, stock: nil, sku: "SKU123", store_id: 1)
      expect(product).not_to be_valid
      expect(product.errors[:stock]).to include("can't be blank")
    end

    it "is not valid without an sku" do
      product = Product.new(name: "Product Name", price: 10.0, stock: 5, sku: nil, store_id: 1)
      expect(product).not_to be_valid
      expect(product.errors[:sku]).to include("can't be blank")
    end

    it "is not valid without a store_id" do
      product = Product.new(name: "Product Name", price: 10.0, stock: 5, sku: "SKU123", store_id: nil)
      expect(product).not_to be_valid
      expect(product.errors[:store_id]).to include("can't be blank")
    end

    it "is valid with all attributes present" do
      store = Store.create(name: "Store Name", description: "Store Description")
      product = Product.new(name: "Product Name", price: 10.0, stock: 5, sku: "SKU123", store_id: store.id)
      expect(product).to be_valid
    end
  end

  describe "database" do
    it "can save a valid product" do
      store = Store.create(name: "Store Name", description: "Store Description")
      product = Product.new(name: "Valid Product", price: 10.0, stock: 5, sku: "SKU123", store_id: store.id)
      expect(product.save).to be true
    end

    it "cannot save an invalid product" do
      store = Store.create(name: "Store Name", description: "Store Description")
      product = Product.new(name: nil, price: 10.0, stock: 5, sku: "SKU123", store_id: store.id)
      expect(product.save).to be false
    end
  end
end
