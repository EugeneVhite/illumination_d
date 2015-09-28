class AddCountryToManufacturer < ActiveRecord::Migration
  def change
    add_reference :manufacturers, :country, index: true, foreign_key: true
  end
end
