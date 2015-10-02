class CartsController < ApplicationController

  include NavigationSideBar
  before_action :set_side_bar_categories, only: :index

  def index
    @products = CartsController::products_from_cart(self)
  end

  def add_item

    CartsController::add_to_cart(self, params[:product_id])

    respond_to do |format|
      format.js
      format.json { render nothing: true }
    end
  end

  def remove_item
    CartsController::remove_from_cart(self, params[:product_id])
    respond_to do |format|
      format.json { render nothing: true }
    end

  end

  def check_out
    redirect_to orders_new_path
  end

  # for debugging ONLY
  def pure
    CartsController::clear_cart self
    redirect_to cart_path
  end


  # methods for working with clients cart
  def self.cart(controller)
    controller.session[:cart]
  end

  def self.set_cart (controller, cart)
    controller.session[:cart] = cart
  end

  def self.add_to_cart(controller, product_id)
    cart = controller.session[:cart] ||= {}

    cart[product_id] ||= {price: Product.find(product_id).price, 'amount' => 0}
    cart[product_id]['amount'] += 1

    controller.session[:cart] = cart
  end

  def self.remove_from_cart(controller, product_id)
    cart = controller.session[:cart]

    if cart[product_id]
      if cart[product_id]['amount'] > 1
        cart[product_id]['amount'] -= 1
      else
        cart.except!(product_id)
      end
    end

    controller.session[:cart] = cart
  end

  def self.clear_cart(controller)
    controller.session[:cart] = nil
  end


  def self.products_from_cart(controller)
    products = Hash.new
    if CartsController::cart(controller)
      CartsController::cart(controller).each do |key, value|
        product = Product.find(key)

        cart_item = product.slice(:name, :article_number, :price)
        cart_item[:amount] = value['amount']
        cart_item[:image_url] = product.image.url

        products[key] = cart_item
      end
    end
    products
  end

  def self.total_price(controller)
    sum = 0
    CartsController::cart(controller).each { |id, item| sum += item['price'].to_d * item['amount'] }
    sum
  end

end
