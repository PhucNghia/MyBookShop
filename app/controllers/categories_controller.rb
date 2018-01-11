class CategoriesController < ApplicationController
  before_action :load_category, except: [:index, :new, :create]

  def index
    @categories = Category.info_category.order(id: :isc).page(params[:page]).
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
end
