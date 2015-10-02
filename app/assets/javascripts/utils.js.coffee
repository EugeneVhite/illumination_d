@toCurrency = (floatValue) ->
  '₽' + Number(floatValue).toLocaleString()

@toOrderPage = ->
  '/orders/new'

@product_path = (product_id) ->
  '/products/' + Number(product_id).toLocaleString()