class OrdersController < ApplicationController
  include NavigationSideBar

  before_action :set_side_bar_categories, only: [:index, :new, :create, :single_click]


  def index
  end

  def new
    @order = Order.new
    @cart = CartsController::cart(self)
    @products = CartsController::products_from_cart(self)
  end

  def create
    @order = Order.new(order_params)

    if @order.save
      # create connections between products and order
      CartsController::cart(self).each do |product_id, amount|
        OrderItem.create(product: Product.find(product_id), order: @order, amount: amount)
      end

      if session[:old_cart]
        CartsController::set_cart(self, session[:old_cart])
        session[:old_cart] = nil
      end

      # TODO render "success"
      redirect_to root_path
    else
      @cart = CartsController::cart(self)
      @products = CartsController::products_from_cart(self)
      render :new
    end
  end

  def single_click
    session[:old_cart] = CartsController::cart(self)
    CartsController::set_cart self, { product_params[:product_id] => 1 }
    redirect_to orders_new_path
  end

  private

  def order_params
    params.require(:order).permit(:name, :email, :phone_number, :description, :address)
  end

  def product_params
    params.permit(:product_id)
  end

end
