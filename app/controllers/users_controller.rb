class UsersController < ApplicationController
  before_action :load_user, except: [:index, :new, :create]
  before_action :user_admin, only: [:index, :destroy]

  def index
    @users = User.info_user.order(id: :asc).page(params[:page]).per(Settings.perpage)
  end

  def show
  end

  def new
    @user = User.new
    @submit = true
  end

  def edit
  end

  def create
    @user = User.new user_params
    if @user.save
      logn_in @user
      flash[:success] = t "controller.users_controller.success_signup"
      redirect_to root_path
    else
      render :new
    end
  end

  def update
    if @user.update_attributes user_params
      logn_in @user
      flash[:success] = t "controller.users_controller.success_update"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "controller.users_controller.success_delete"
      redirect_to users_url
    else
      flash[:danger] = t "controller.users_controller.cant_delete"
      render :index
    end
  end

  private

  def load_user
    @user = User.find_by_id params[:id]
    return if @user
    flash[:danger] = t "controller.users_controller.no_account"
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit :name, :password, :password_confirmation,
      :email, :phone, :address, :role
  end
end
