class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @store = Store.find_by(id: @order.store_id)
  end

  def new
    @order = Order.new
  end

  def edit
  end

  def create
    @order = Order.new(order_params)
    @product = @order.product
  
    if @order.valid? && sufficient_stock?
      new_stock = @product.stock - @order.shipping.to_i
  
      if new_stock >= 0
        @product.update(stock: new_stock)
        redirect_to @order, notice: 'Ordem criada com sucesso.'
      else
        flash.now[:alert] = 'Quantidade em estoque insuficiente para criar a ordem.'
        render :new, status: :unprocessable_entity
      end
    else
      flash.now[:alert] = 'Por favor, corrija os erros abaixo.'
      render :new, status: :unprocessable_entity
    end
  end

  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to order_url(@order), notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:client_name, :shipping, :product_id)
    end

    def sufficient_stock?
      @order.shipping.to_i <= @product.stock
    end
end
