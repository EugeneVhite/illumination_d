module CartHelper
  def add_item_to_cart_path(product_id)
    "/carts/add_item/#{product_id}"
  end

  def cart_total_price
    CartsController::total_price(self)
  end
end
