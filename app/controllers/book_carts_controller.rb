class BookCartsController < ApplicationController
  before_action :load_book_cart, except: [:index, :new, :create]

  def index
    @book_carts = BookCart.info_book_cart.order(id: :asc).
      page(params[:page]).per(Settings.perpage)
  end

  def show
  end

  def new
    @book_cart = BookCart.new
  end

  def edit
  end

  def create
    @cart = current_cart
    book = Book.find(params[:book_id])
    @book_cart = @cart.add_book(book.id)
    if @book_cart.save
      redirect_to @book_cart.cart
    else
      render :new
    end
  end

  def update
    if @book_cart.update_attributes book_cart_params
      redirect_to @book_cart
    else
      render :edit
    end
  end

  def destroy
    if @book_cart.destroy
      redirect_to book_carts_url
    else
      render :index
    end
  end

  private

  def load_book_cart
    @book_cart = BookCart.find_by_id params[:id]
    return if @book_cart
    redirect_to root_path
  end

  def book_cart_params
    params.require(:book_cart).permit :carts_id, :books_id, :amount
  end
end
