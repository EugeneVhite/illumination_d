require 'spec_helper'

module HashHelper
  def cart_with_one(product)
    { product.id => {price: product.price, 'amount' => 1} }
  end

  def cart_with_few_the_same(products, amount_of_products)
    { products.id => {price: products.price, 'amount' => amount_of_products} }
  end

  def empty_cart
    {  }
  end


  def cart_item_for(product, amount)
    { name: product.name, price: product.price, article_number: product.article_number, 'amount' => amount, image_url: product.image.url}
  end

  def products_from_cart(products, amounts)
    products_hash = Hash.new

    products.size.times do |i|
      products_hash[products[i].id] = cart_item_for(products[i], amounts[i])
    end
    products_hash
  end
end

RSpec.configure { |c| c.include HashHelper }

describe CartsController, type: :controller do
  describe 'class methods' do
    describe '#storage implementation' do

      it 'should add product to session[]' do
        product = create(:product)
        CartsController::add_to_cart(@controller, product.id)

        expect(@controller.session[:cart]).to eq cart_with_one(product)
      end


      it 'should increase amount of products in session' do
        product = create(:product)
        amount = 2
        amount.times { CartsController::add_to_cart(@controller, product.id) }

        expect(@controller.session[:cart]).to eq cart_with_few_the_same(product, amount)
      end


      it 'should remove products from cart' do
        product = create(:product)
        @controller.session[:cart] = cart_with_one product
        CartsController::remove_from_cart(@controller, product.id)

        expect(@controller.session[:cart]).to eq empty_cart
      end


      it 'should decrease amount of products in cart' do
        product = create(:product)
        amount = 2
        @controller.session[:cart] = cart_with_few_the_same(product, amount)
        CartsController::remove_from_cart(@controller, product.id)

        expect(@controller.session[:cart]).to eq cart_with_few_the_same(product, amount - 1)
      end
    end

    describe '#accessors' do


      it 'should return cart' do
        product = create(:product)
        CartsController::add_to_cart(@controller, product.id)

        expect(CartsController::cart(@controller)).to eq cart_with_one(product)
      end

      it 'should set cart' do
        product = create(:product)
        cart = cart_with_one product
        CartsController::set_cart(@controller, cart)

        expect(CartsController::cart(@controller)).to eq cart_with_one(product)
      end
    end

    describe '#special functionality' do

      it 'should return products in cart_item format' do
        product = create(:product)
        amount = 3
        amount.times { CartsController::add_to_cart(@controller, product.id) }

        products = []
        products << product
        amounts = []
        amounts << amount

        expect( CartsController::products_from_cart(@controller) ).to eq products_from_cart(products, amounts)
      end

      it 'should clear cart' do
        product = create(:product)
        CartsController::add_to_cart(@controller, product.id)
        CartsController::clear_cart(@controller)

        expect(CartsController::cart(@controller)).to be_nil
      end

      it 'should compute total price' do
        amount = 3
        products = []
        amount.times { products << create(:product) }

        CartsController::set_cart(@controller, cart_with_few_the_same(products.first, amount))
        sum = 0.0
        products.each { |product| sum += product.price }

        expect(CartsController::total_price(@controller)).to eq sum
      end
    end

  end

  describe 'instance methods' do
    describe '#GET index' do

      it 'should render :index template' do
        get :index
        response.should render_template('index')
      end

      it 'should populate array of products if cart is not empty' do
        product = create(:product)
        amount = 1
        amount.times { CartsController::add_to_cart(@controller, product.id) }
        get :index
        assigns(:products).should eq products_from_cart([product], [amount])
      end

    end

    describe '#GET add_item' do

      it 'should return ok' do
        product = create(:product)
        get :add_item, product_id: product.id, format: :json
        response.should be_ok
      end

      it 'should add products to cart' do
        product = create(:product)

        get :add_item, product_id: product.id, format: :json
        expect(CartsController::cart(@controller)).to eq cart_with_one(product)
      end

      it 'should increase amount of products' do
        product = create(:product)
        amount = 3
        amount.times { get :add_item, product_id: product.id, format: :json }
        expect(CartsController::cart(@controller)).to eq cart_with_few_the_same(product, amount)
      end
    end

    describe '#GET remove_item' do

      it 'should return ok' do
        product = create(:product)
        CartsController::set_cart(@controller, cart_with_one(product))

        get :remove_item, product_id: product.id, format: :json
        response.should be_ok
      end

      it 'should remove products from cart' do
        product = create(:product)
        CartsController::set_cart(@controller, cart_with_one(product))

        get :remove_item, product_id: product.id, format: :json

        expect(CartsController::cart(@controller)).to eq empty_cart
      end

      it 'should decrease amount of products' do
        product = create(:product)
        amount = 3
        CartsController::set_cart(@controller, cart_with_few_the_same(product, amount))

        get :remove_item, product_id: product.id, format: :json

        expect(CartsController::cart(@controller)).to eq cart_with_few_the_same(product, amount - 1)
      end
    end

    describe '#GET check_out' do
      it 'should be redirected' do
        get :check_out
        response.should redirect_to orders_new_path
      end
    end

  end

end
