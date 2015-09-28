class ProductsController < ApplicationController
  include FilterProducts
  include NavigationSideBar

  before_action :set_product, only: :show
  before_action :set_side_bar_categories, only: [:index, :show]


  # GET /products
  # GET /products.json
  def index
    # TODO: implement search
    if params[:product]
      @products = filter_products(params[:product]) # app/controllers/concerns/filter_products.rb
    else
      @products = Product.all
    end

    respond_to do |format|
      format.html
      format.js
      format.json { render json: @products }
    end

  end

  # GET /products/1
  # GET /products/1.json
  def show

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :description, :price, :article_number, :remote_control, :color)
    end
end
