class PublishersController < ApplicationController
  before_action :load_publisher, except: [:index, :new, :create]

  def index
    @publishers = Publisher.info_publisher.order(id: :asc).
      page(params[:page]).per(Settings.perpage)
  end

  def show
  end

  def new
    @publisher = Publisher.new
  end

  def edit
  end

  def create
    @publisher = Publisher.new publisher_params
    if @publisher.save
      flash[:success] = t "controller.publishers_controller.create_publisher"
      redirect_to @publisher
    else
      render :new
    end
  end

  def update
    if @publisher.update_attributes publisher_params
      flash[:success] = t "controller.publishers_controller.update_publisher"
      redirect_to @publisher
    else
      render :edit
    end
  end

  def destroy
    if @publisher.destroy
      flash[:success] = t "controller.publishers_controller.delete_publisher"
      redirect_to publishers_url
    else
      render :index
    end
  end

  private

  def load_publisher
    @publisher = Publisher.find_by_id params[:id]
    return if @publisher
    flash[:danger] = t "controller.publishers_controller.no_fine_publisher"
    redirect_to root_path
  end

  def publisher_params
    params.require(:publisher).permit :name
  end
end
