require 'rails_helper'

RSpec.describe "Products", type: :request do
  describe "POST /create" do
    it "with invalid parameters renders a response with 422 status" do
      post products_url, params: { product: { name: nil, price: 10.0, stock: 5, sku: "SKU-123", store_id: 1 } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PATCH /update" do
    let(:product) { create(:product) }

    it "with invalid parameters renders a response with 422 status" do
      patch product_url(product), params: { product: { name: nil } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
