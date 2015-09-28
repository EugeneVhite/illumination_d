class CreateTechnicalFeatures < ActiveRecord::Migration
  def change
    create_table :technical_features do |t|
      t.string :cap_type
      t.string :lamp_type
      t.decimal :height
      t.decimal :width
      t.decimal :length
      t.decimal :diameter
      t.integer :amount_of_lamps
      t.decimal :one_lamp_power
      t.decimal :total_power
      t.decimal :illum_area

      t.timestamps
    end
  end
end
