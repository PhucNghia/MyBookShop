class AuthorsController < ApplicationController
  before_action :load_author, except: [:index, :new, :create]

  def index
    @authors = Author.info_author.order(id: :asc).page(params[:page]).
      per(Settings.perpage)
  end

  def show
  end

  def new
    @author = Author.new
  end

  def edit
  end

  def create
    @author = Author.new author_params
    if @author.save
      flash[:success] = t "controller.authors_controller.create_author"
      redirect_to @author
    else
      render :new
    end
  end

  def update
    if @author.update_attributes author_params
      flash[:success] = t "controller.authors_controller.update_author"
      redirect_to @author
    else
      render :edit
    end
  end

  def destroy
    if @author.destroy
      flash[:success] = t "controller.authors_controller.delete_author"
      redirect_to authors_url
    else
      render :index
    end
  end

  private

  def load_author
    @author = Author.find_by_id params[:id]
    return if @author
    flash[:danger] = t "controller.authors_controller.no_find_author"
    redirect_to root_path
  end

  def author_params
    params.require(:author).permit :name
  end
end
