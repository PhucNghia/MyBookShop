class StaticPagesController < ApplicationController
  def home
    @q = Book.ransack params[:q]
    @books = @q.result(distinct: true).order(id: :asc).page(params[:page])
      .per Settings.perhomepage
    @dem = 0
    @cart = current_cart
  end
end
