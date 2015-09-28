class OrdersController < ApplicationController
  include NavigationSideBar


  def index
  end

  def new

  end

  def create
    @order = Order.new(order_params)

    if @order.save
      redirect_to root_path
    else
      
    end
  end

  def single_click
    redirect_to Product.find(params[:product_id])
  end

  private

  def order_params
    params.require(:order).permit(:name, :email, :phone_number, :description, :address)
  end

end
