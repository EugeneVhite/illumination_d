module OrdersHelper

  def turbo_purchase_path(product_id)
    "/orders/single_click/#{product_id}"
  end
end
