require 'rails_helper'

RSpec.describe "/products", type: :request do
  let!(:store) do
    Store.create!(name: "Store teste", description: "Test 123")
  end

  let(:valid_attributes) do
    {
      name: "Valid Product",
      price: 10.0,
      stock: 5,
      sku: "SKU123",
      store_id: store.id
    }
  end

  let(:invalid_attributes) do
    {
      name: "Valid Product",
      price: nil,
      stock: 5,
      sku: "SKU123",
      store_id: store.id
    }
  end

  describe "GET /index" do
    it "renders a successful response" do
      Product.create! valid_attributes
      get products_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      product = Product.create! valid_attributes
      get product_url(product)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_product_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      product = Product.create! valid_attributes
      get edit_product_url(product)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Product" do
        expect {
          post products_url, params: { product: valid_attributes }
        }.to change(Product, :count).by(1)
      end

      it "redirects to the created product" do
        post products_url, params: { product: valid_attributes }
        expect(response).to redirect_to(product_url(Product.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Product" do
        expect {
          post products_url, params: { product: invalid_attributes }
        }.to change(Product, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post products_url, params: { product: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { name: "Updated Product Name", price: 15.0, stock: 10, sku: "SKU456", store_id: store.id }
      }

      it "updates the requested product" do
        product = Product.create! valid_attributes
        patch product_url(product), params: { product: new_attributes }
        product.reload
        expect(product.name).to eq("Updated Product Name")
        expect(product.price).to eq(15.0)
        expect(product.stock).to eq(10)
        expect(product.sku).to eq("SKU456")
      end

      it "redirects to the product" do
        product = Product.create! valid_attributes
        patch product_url(product), params: { product: new_attributes }
        product.reload
        expect(response).to redirect_to(product_url(product))
      end
    end

    context "with invalid parameters" do
    
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        product = Product.create! valid_attributes
        patch product_url(product), params: { product: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested product" do
      product = Product.create! valid_attributes
      expect {
        delete product_url(product)
      }.to change(Product, :count).by(-1)
    end

    it "redirects to the products list" do
      product = Product.create! valid_attributes
      delete product_url(product)
      expect(response).to redirect_to(products_url)
    end
  end
end
