json.array!(@products) do |product|
  json.extract! product, :id, :name, :description, :price, :article_number, :remote, :type_id, :manufacturer_id
  json.url product_url(product, format: :json)
end
