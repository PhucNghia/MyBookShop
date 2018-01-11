class SessionCartsController < ApplicationController

  def create
    book = Book.find params[:book_id]
    quantity = 1
    arr = Array.new
    if session[:current_book].nil?
      add_array arr, book.id, quantity, book.price
      session[:current_book] ||= []
      session[:current_book] << arr
    else
      i = 0
      index = -1
      session[:current_book].each do |b|
        if book.id == b[0]
          quantity = b[1] + 1
          index = i
        end
        i += 1
      end
      if index == -1
        add_array arr, book.id, quantity, book.price
        session[:current_book] << arr
      else
        session[:current_book][index][1] = quantity
        session[:current_book][index][2] = book.price*quantity
      end
    end
    redirect_to cart_index_path
  end

  def index
    @product ||= []
    if session[:current_book].nil?
      flash[:danger] = "Gio hang rong!"
      redirect_to root_path
    else
      total_price = 0
      session[:current_book].each do |book|
        b = Book.find_by id: book[0]
        infor = Array.new
        add_array infor, b, book[1], book[2]
        total_price += book[2]
        @product << infor
      end
      session[:total_price] = total_price
    end
  end

  def destroy
    book_id = params[:book_id].to_i
    if book_id != -1
      i = 0
      length = session[:current_book].length
      session[:current_book].each do |b|
        if book_id == b[0]
          session[:current_book].delete_at(i)
          if length == 1
            delete_session_cart
          else
            flash[:success] = "Xoa thanh cong"
            redirect_to cart_index_path
          end
        end
        i += 1
      end
    else
      delete_session_cart
    end
  end
end
