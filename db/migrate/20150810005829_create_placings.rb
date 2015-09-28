class CreatePlacings < ActiveRecord::Migration
  def change
    create_table :placings do |t|
      t.belongs_to :product, index: true
      t.belongs_to :recommended_place, index: true

      t.timestamps
    end
  end
end
