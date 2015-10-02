@Cart = React.createClass
  totalSumOfOrder: ->
    sum = 0.0
    keys = Object.keys(@state.cart)
    for key in keys
      sum += parseFloat(@state.cart[key].price * @state.cart[key].amount)
    return sum

  getInitialState: ->
    cart: @props.data
  getDefaultProps: ->
    cart: []

  change_is_in_the_air: (id, direction) ->

    cart = @state.cart
    if direction > 0
      cart[id].amount += 1
    else
      cart[id].amount -= 1
      if cart[id].amount == 0
        delete cart[id]

    @setState cart: cart

  render: ->
    keys = Object.keys(@state.cart)

    React.DOM.div
      id: 'content_of_cart'
      #React.DOM.h1 null, 'Ваша корзина'
      for key in keys
        React.createElement Cart_item, key: key, product: {data: @state.cart[key], id: key}, handleChange: @change_is_in_the_air
      React.DOM.div
        className: 'bill'
        React.DOM.h2 null,
          'Ваш заказ'
        React.DOM.p null,
          'Заказ на общую сумму:'
        React.DOM.h3 null, toCurrency(@totalSumOfOrder())
        React.DOM.a href: toOrderPage(), id: 'order',
          'Оформить заказ'

