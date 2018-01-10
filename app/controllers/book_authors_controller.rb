class BookAuthorsController < ApplicationController
  before_action :load_book_author, except: [:index, :new, :create]

  def index
    @book_authors = BookAuthor.info_book_author.order(id: :asc).
      page(params[:page]).per(Settings.perpage)
  end

  def show
  end

  def new
    @book_author = BookAuthor.new
  end

  def edit
  end

  def create
    @book_author = BookAuthor.new book_author_params
    if @book_author.save
      redirect_to @book_author
    else
      render :new
    end
  end

  def update
    if @book_author.update_attributes book_author_params
      redirect_to @book_author
    else
      render :edit
    end
  end

  def destroy
    if@book_author.destroy
      redirect_to book_authors_url
    else
      render :index
    end
  end

  private

  def load_book_author
    @book_author = BookAuthor.find_by_id params[:id]
    return if @book_author
    redirect_to root_path
  end

  def book_author_params
    params.require(:book_author).permit:book_id, :author_id
  end
end
