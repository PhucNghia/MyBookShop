class Admin::UsersController < ApplicationController

  before_action :load_user, except: [:index, :new, :create]
  before_action :user_admin, only: [:index]

  def index
    @q = User.ransack params[:q]
    @users = @q.result(distinct: true).order(id: :asc).page(params[:page])
      .per Settings.perpage
  end

  def show
  end

  def new
    @user = User.new
    @check_new = true
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "controller.users_controller.success_signup"
      redirect_to user_params
    else
      render :new
    end
  end

  def edit
    @user = User.find_by_id params[:id]
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = "cap nhat thanh cong"
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "controller.users_controller.success_delete"
      redirect_to admin_users_path
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
    params.require(:user).permit :name, :email, :password, :password_confirmation,
       :phone, :address, :role
  end

  def user_admin
    unless current_user && current_user.admin?
      redirect_to root_path
    end
  end
end
