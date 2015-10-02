@Cart_item = React.createClass
  handleIncrement: (e) ->
    $.get '/carts/add_item/' + e.target.id, null,
      @incrementAmount( e.target.id, 1), 'JSON'

  handleDecrement: (e) ->
    $.get '/carts/remove_item/' + e.target.id, null,
      @incrementAmount( e.target.id, -1), 'JSON'



  incrementAmount: (id, direction) ->
    @props.handleChange id, direction

  render: ->
    React.DOM.article null,
      React.DOM.img
        src: @props.product.data.image_url
      React.DOM.div
        className: 'item_description'
        React.DOM.h3 null,
          React.DOM.a className: 'product_name', href: product_path(@props.product.id), @props.product.data.name
        React.DOM.p null, @props.product.data.article_number
        React.DOM.span id: 'price', toCurrency(@props.product.data.price)
        React.DOM.button
          id: @props.product.id
          className: 'increment_button'
          onClick: @handleIncrement
          '+'
        React.DOM.span className: 'amount', @props.product.data.amount
        React.DOM.button
          id: @props.product.id
          className: 'decrement_button'
          onClick: @handleDecrement
          '-'
