class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      logn_in user
      redirect_to root_path
    else
      flash.now[:danger] = t "controller.sessions_controller.error_login"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
