require 'rails_helper'

RSpec.describe "Orders", type: :request do
  let!(:product_with_sufficient_stock) { create(:product, stock: 10) }
  let!(:product_with_insufficient_stock) { create(:product, stock: 5) }
  

  describe "GET /index" do
    it "renders a successful response" do
      store = create(:store)
      create(:order, product: product_with_sufficient_stock, shipping: 5, store: store)
  
      get orders_url
      expect(response).to be_successful
    end
  end
  

  describe "POST /create", skip: true do
    it "creates a new Order with valid parameters" do
      expect {
        post orders_url, params: { order: { client_name: "John Doe", shipping: 15, product_id: product_with_insufficient_stock.id, skip_stock_validation: true } }
      }.to change(Order, :count).by(1)
    end
  
    it "redirects to the created order with valid parameters" do
      post orders_url, params: { order: { client_name: "John Doe", shipping: 5, product_id: product_with_sufficient_stock.id } }
      expect(response).to redirect_to(order_url(Order.last))
    end
  end
  

  describe "GET /show" do
    it "renders a successful response" do
      order = create(:order, product: product_with_sufficient_stock, shipping: 5)
      get order_url(order)
      expect(response).to be_successful
    end
  end

  describe "model validations" do
    it "is not valid without a client_name" do
      order = build(:order, client_name: nil, product: product_with_sufficient_stock, shipping: 5)
      expect(order).not_to be_valid
    end

    it "is not valid without a shipping" ,skip: true do
      order = build(:order, shipping: nil, product: product_with_sufficient_stock)
      expect(order).not_to be_valid
    end

    it "is not valid without a product_id", skip: true do
      order = build(:order, product: nil, shipping: 5)
      expect(order).not_to be_valid
    end

    it "is valid with all attributes present and sufficient stock" do
      order = build(:order, product: product_with_sufficient_stock, shipping: 5)
      expect(order).to be_valid
    end

    it "is not valid with shipping greater than stock" do
      order = build(:order, product: product_with_insufficient_stock, shipping: 10)
      expect(order).not_to be_valid
    end

    it "can save a valid order" do
      order = build(:order, product: product_with_sufficient_stock, shipping: 5)
      expect(order.save).to be true
    end
  end
end
