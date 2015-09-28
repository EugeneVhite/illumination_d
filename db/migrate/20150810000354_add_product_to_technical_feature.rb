class AddProductToTechnicalFeature < ActiveRecord::Migration
  def change
    add_reference :technical_features, :product, index: true
  end
end
