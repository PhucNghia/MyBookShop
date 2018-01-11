class UsersController < ApplicationController
  before_action :load_user, except: [:index, :new, :create]
  before_action :user_admin

  def index
    @users = User.info_user.order(id: :asc).page(params[:page]).per(Settings.perpage)
  end

  def show
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
