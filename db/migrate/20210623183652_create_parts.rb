class CreateParts < ActiveRecord::Migration[6.0]
  def change
    create_table :parts do |t|
      t.integer :part_category_id
      t.string :part_number
      t.string :name
      t.string :color
      t.string :image_url
      t.boolean :for_match

      t.timestamps
    end
  end
end
