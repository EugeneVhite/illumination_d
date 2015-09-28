class DropStyleFeatures < ActiveRecord::Migration
  def change
    drop_table :style_features
  end
end
