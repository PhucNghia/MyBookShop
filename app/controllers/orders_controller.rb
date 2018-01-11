class OrdersController < ApplicationController
  before_action :load_order, only: [:show, :edit, :update, :destroy]

  def index
    @orders = Order.all
  end

  def show
  end

  def new
    @cart = current_cart
    if @cart.book_carts.empty?
        redirect_to '/', :notice => 'Your cart is empty'
        return
    end
    @order = Order.new
  end

  def edit
  end

  def create
    @order = Order.new(order_params)
    # @order.add_book_carts_from_cart(current_cart)

    if @order.save
      # Cart.destroy(session[:cart_id])
        # session[:cart_id] = nil
        redirect_to root_path
    else
      render :new
    end
  end

  def update
    if @order.update(order_params)
      redirect_to @order
    else
      render :edit
    end
  end

  def destroy
    if @order.destroy
      redirect_to orders_url
    else
      render :index
    end
  end

  private

  def load_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:name, :phone, :address, :email, :pay_type)
  end
end
