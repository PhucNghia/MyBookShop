class OrdersController < ApplicationController
  before_action :load_order, except: [:index, :new, :create]
  before_action :join_book_order, only: [:index, :show]
  before_action :check_order, only: [:new, :create]
  before_action :index_orders, only: [:index]
  before_action :show_orders, only: [:show, :edit]

  def index
    @orders = Order.info_order.order(id: :asc).page(params[:page]).
      per(Settings.perpage)
  end

  def show
  end

  def new
    if current_user.nil?
      flash[:notice] = t "controller.order_controller.before_signup"
      redirect_to new_user_session_path
    else
      @order = Order.new
    end
  end

  def edit
  end

  def create
    @order = Order.new order_params
    if @order.save
      session[:current_cart].each do |key, book|
        @order.add_order_item @order.id, book["id"], book["quantity"]
      end
      flash[:success] = t "controller.order_controller.success_order"
      session[:all_product] = nil
      session[:all_price] = nil
      delete_session_cart
    else
      flash[:dange] = t "controller.order_controller.fail_order"
      render :new
    end
  end

  def update
    if @order.update_attributes order_params
      flash[:success] = t "controller.order_controller.update_order"
      redirect_to @order
    else
      render :edit
    end
  end

  def destroy
    if @order.destroy
      flash[:success] = t "controller.order_controller.delete_order"
      redirect_to orders_url
    else
      render :index
    end
  end

  private

  def load_order
    @order = Order.find_by_id params[:id]
    return if @order
    flash[:danger] = t "controller.order_controller.no_find_order"
  end

  def order_params
    params.require(:order).permit :user_id, :name, :phone, :address, :email,
      :all_product, :all_price
  end

  def join_book_order
    @join_book_order = OrderItem.joins(:book, :order)
  end

  def check_order
    if session[:current_cart].nil?
      redirect_to root_path
    end
  end

  def index_orders
    unless current_user && current_user.admin?
      redirect_to root_path
    end
  end

  def show_orders
    unless current_user
      redirect_to root_path
    end
  end
end
