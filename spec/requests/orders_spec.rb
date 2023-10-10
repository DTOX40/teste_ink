# spec/requests/orders_spec.rb

require 'rails_helper'

RSpec.describe "/orders", type: :request do
  let!(:store) { create(:store) }

  let!(:product) do
    create(:product, name: "Product Name", price: 10.0, stock: 5, sku: "SKU123", store: store)
  end

  let(:valid_attributes) do
    {
      client_name: "John Doe",
      shipping: 3, # Quantidade de envio menor ou igual ao estoque
      product_id: product.id,
      store_id: store.id, # Certifique-se de associar o pedido à loja existente
      skip_stock_validation: false # Defina isso como true quando necessário
    }
  end

  let(:invalid_attributes) do
    {
      client_name: nil,
      shipping: 10.50,
      product_id: product.id,
      store_id: store.id # Certifique-se de associar o pedido à loja existente
    }
  end

  describe "GET /index" do
    it "renders a successful response" do
      Order.create! valid_attributes
      get orders_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      order = Order.create! valid_attributes
      get order_url(order)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_order_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      order = Order.create! valid_attributes
      get edit_order_url(order)
      expect(response).to be_successful
    end
  end

  describe "POST /create", skip: true do
    context "with valid parameters" do
      it "creates a new Order" do
        expect {
          post orders_url, params: { order: valid_attributes }
        }.to change(Order, :count).by(1)
      end
    
      it "redirects to the created order" do
        post orders_url, params: { order: valid_attributes }
        expect(response).to redirect_to(order_url(Order.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Order" do
        expect {
          post orders_url, params: { order: invalid_attributes }
        }.to change(Order, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post orders_url, params: { order: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) do
        {
          client_name: "Updated John Doe",
          shipping: 9.99,
          product_id: product.id,
          store_id: store.id, # Certifique-se de associar o pedido à loja existente
          skip_stock_validation: true # Desativa temporariamente a validação de estoque
        }
      end

      it "updates the requested order" do
        order = Order.create! valid_attributes
        patch order_url(order), params: { order: new_attributes }
        order.reload
        expect(order.client_name).to eq("Updated John Doe")
        expect(order.shipping).to be_within(1e-9).of(9.99)
      end

      it "redirects to the order" do
        order = Order.create! valid_attributes
        patch order_url(order), params: { order: new_attributes }
        order.reload
        expect(response).to redirect_to(order_url(order))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        order = Order.create! valid_attributes
        patch order_url(order), params: { order: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested order" do
      order = Order.create! valid_attributes
      expect {
        delete order_url(order)
      }.to change(Order, :count).by(-1)
    end

    it "redirects to the orders list" do
      order = Order.create! valid_attributes
      delete order_url(order)
      expect(response).to redirect_to(orders_url)
    end
  end
end
