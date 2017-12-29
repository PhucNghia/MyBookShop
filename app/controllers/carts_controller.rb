class CartsController < ApplicationController
  before_action :load_cart, except: [:index, :new, :create]

  def show
  end

  def new
    @cart = Cart.new
  end

  def edit
  end

  def create
    @cart = Cart.new cart_params
    if @cart.save
      redirect_to @cart
    else
      render :new
    end
  end

  def update
    if @cart.update_attributes cart_params
      redirect_to @cart
    else
      render :edit
    end
  end

  def destroy
    @cart = current_cart
    @cart.destroy
    session[:cart_id] = nil
    if @cart.destroy
      redirect_to carts_url
    else
      render :index
    end
  end

  private

  def load_cart
    @cart = Cart.find_by_id params[:id]
    return if @cart
    flash[:danger] = t "controller.carts_controller.no_find_cart"
    redirect_to root_path
  end

  def cart_params
    params.fetch(:cart, {})
  end
end
