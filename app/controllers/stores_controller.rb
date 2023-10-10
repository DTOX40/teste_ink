class StoresController < ApplicationController
  before_action :set_store, only: %i[show edit update destroy]

  def index
    @stores = Store.all
  end

  def show
    @store = Store.find(params[:id])
  end

  def new
    @store = Store.new
  end

  def edit
  end

  def create
    @store = Store.new(store_params)

    respond_to do |format|
      if @store.save
        format.html { redirect_to store_url(@store), notice: "Store was successfully created." }
        format.json { render :show, status: :created, location: @store }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @store.update(store_params)
        format.html { redirect_to store_url(@store), notice: "Store was successfully updated." }
        format.json { render :show, status: :ok, location: @store }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @store.destroy

    respond_to do |format|
      format.html { redirect_to stores_url, notice: "Store was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def products_sales
    @store = Store.find(params[:id])
    @products = @store.products.includes(:orders)
    @product_sales = {}

    @products.each do |product|
      total_sales = product.orders.count
      @product_sales[product] = total_sales
    end

    render "products_sales"
  end

  def orders
    @store = Store.find(params[:id])
    @orders = @store.orders.includes(:product)

    render "orders"
  end

  def top_stores
    @top_stores = Store
      .select('stores.*, SUM(orders.shipping + products.price) AS total_revenue')
      .joins(orders: :product)
      .group('stores.id')
      .order('total_revenue DESC')
      .limit(10)
  
    render 'top_stores'
  end

  def top
    @top_stores = Store.top_10
  end

  private

  def set_store
    @store = Store.find(params[:id])
  end

  def store_params
    params.require(:store).permit(:name, :description)
  end
end
