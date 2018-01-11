class CategoriesController < ApplicationController
  before_action :load_category, except: [:index, :new, :create]
  before_action :index_categories, only: [:index, :show, :edit]
  def index
    @categories = Category.info_category.order(id: :asc).page(params[:page]).
      per(Settings.perpage)
  end

  def show
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new category_params

    if @category.save
      flash[:success] = t "controller.categories_controller.create_category"
      redirect_to @category
    else
      render :new
    end
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "controller.categories_controller.update_category"
      redirect_to @category
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "controller.categories_controller.delete_category"
      redirect_to categories_url
    else
      render :index
    end
  end

  private

  def load_category
    @category = Category.find_by_id params[:id]
    return if @category
    flash[:danger] = t "controller.categories_controller.no_find_category"
  end

  def category_params
    params.require(:category).permit :name
  end

  def index_categories
    unless current_user && current_user.admin?
      redirect_to root_path
    end
  end
end
