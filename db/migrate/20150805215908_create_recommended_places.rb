class CreateRecommendedPlaces < ActiveRecord::Migration
  def change
    create_table :recommended_places do |t|
      t.string :name

      t.timestamps
    end
  end
end
