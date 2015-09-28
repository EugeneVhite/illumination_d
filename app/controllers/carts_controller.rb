class CartsController < ApplicationController

  include NavigationSideBar
  before_action :set_side_bar_categories, only: :index
  def index
    @products = find_all_products
  end

  def add_item
    session[:cart] ||= {}

    session[:cart][params[:product_id]] ||= 0
    session[:cart][params[:product_id]] += 1


    respond_to do |format|
      format.js
      format.json
    end
  end

  def remove_item

    amount = session[:cart][params[:product_id]]
    if amount > 1
      session[:cart][params[:product_id]] -= 1
    else
      session[:cart].except!(params[:product_id])
    end

    redirect_to carts_index_path
  end

  def check_out
    redirect_to orders_new_path
  end

  # for debugging ONLY
  def pure
    session[:cart] = nil
    redirect_to cart_path
  end

  private

  def find_all_products
    products = Array.new
    if session[:cart]
      session[:cart].each do |key, value|
        products << Product.find(key)
      end
    end
    products
  end

end
