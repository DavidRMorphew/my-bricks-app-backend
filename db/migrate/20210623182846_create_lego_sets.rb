class CreateLegoSets < ActiveRecord::Migration[6.0]
  def change
    create_table :lego_sets do |t|
      t.integer :theme_id
      t.string :set_number
      t.string :name
      t.string :image_url
      t.string :instructions_url
      t.integer :year
      t.boolean :owned
      t.boolean :potential_build
      t.integer :total_bricks

      t.timestamps
    end
  end
end
