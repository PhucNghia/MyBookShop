class StaticPagesController < ApplicationController
  def home
    @books = Book.info_book.order(id: :asc).page(params[:page]).
      per(Settings.perhomepage)
    @dem = 0
    @cart = current_cart
  end
end
