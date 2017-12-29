class Namespace::ObjectController < ApplicationController

  before_action :load_user, only: [:show, :edit, :update, :destroy]

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
