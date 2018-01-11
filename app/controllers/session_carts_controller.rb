class SessionCartsController < ApplicationController

  @@index = 0
  def create
    book = Book.find params[:book_id]
    quantity = 1
    total_price = book.price
    hash_book = Hash.new
    if session[:current_book].nil?
      add_array hash_book, book.id, book.picture, book.name, book.price,
        quantity, total_price
      session[:current_book] = Hash.new
      session[:current_book][@@index] = hash_book
    else
      index = -1
      session[:current_book].each do |key, val|
        if book.id == val["id"]
          quantity = val["quantity"] + 1
          index = key
        end
      end
      if index == -1
        add_array hash_book, book.id, book.picture, book.name, book.price,
          quantity, total_price
        @@index += 1
        session[:current_book][@@index] = hash_book
      else
        session[:current_book][index]["quantity"] = quantity
        session[:current_book][index]["total_price"] = book.price*quantity
      end
    end
    redirect_to cart_index_path
  end

  def index
    if !session[:current_book].nil?
      all_price = 0
      all_product = 0
      session[:current_book].each do |key, book|
        all_price += book["total_price"]
        all_product += book["quantity"]
      end
      session[:all_price] = all_price
      session[:all_product] = all_product
    end
  end

  def destroy
    book_id = params[:book_id].to_i
    if book_id != -1
      length = session[:current_book].length
      session[:current_book].each do |key, book|
        if book_id == book["id"]
          session[:current_book].delete(key)
          if length == 1
            delete_session_cart
          else
            flash[:success] = t "controller.sessions_carts_controller.delete_product"
            redirect_to cart_index_path
          end
        end
      end
    else
      delete_session_cart
    end
  end
end
