class UsersController < ApplicationController

  before_action :load_user, only: [:show, :edit, :update]

  def index
    @users = User.all
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
      redirect_to @user
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

  private

    def load_user
      @user = User.find_by_id params[:id]
      return if @user
      flash[:danger] = t "controller.users_controller.no_account"
      redirect_to root_path
    end

    def user_params
      params.require(:user).permit :name, :password, :password_confirmation,
        :email, :phone, :address
    end
end
