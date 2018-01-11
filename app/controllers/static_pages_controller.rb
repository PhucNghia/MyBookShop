class StaticPagesController < ApplicationController
  def home
    @q = Book.ransack params[:q]
    @books = @q.result(distinct: true).order(id: :asc).page(params[:page])
      .per Settings.perhomepage
  end
end
