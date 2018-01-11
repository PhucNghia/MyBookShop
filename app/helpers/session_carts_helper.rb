module SessionCartsHelper

  def add_array hash_book, id, picture, name, price, quantity, total_price
    hash_book[:id] = id
    hash_book[:picture] = picture
    hash_book[:name] = name
    hash_book[:price] = price
    hash_book[:quantity] = quantity
    hash_book[:total_price] = total_price
  end

  def delete_session_cart
    session[:current_book] = nil
    @product = nil
    redirect_to root_path
  end
end
