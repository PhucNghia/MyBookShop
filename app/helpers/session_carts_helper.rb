module SessionCartsHelper

  def add_array arr, id, quantity, price
    arr << id
    arr << quantity
    arr << price
  end

  def delete_session_cart
    session[:current_book] = nil
    @product = nil
    redirect_to root_path
  end
end
