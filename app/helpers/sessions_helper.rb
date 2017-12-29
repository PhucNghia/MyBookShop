module SessionsHelper
  def logn_in user
    session[:user_id] = user.id
    session[:name] = user.name
  end

  def current_user
    @current_user ||= User.find_by id: session[:user_id]
    return @current_user
  end

  def logged_in?
    current_user.present?
  end

  def log_out
    session.delete :user_id
    @current_user = nil
  end
end
