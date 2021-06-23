class CreatePartCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :part_categories do |t|
      t.string :category_number
      t.string :name

      t.timestamps
    end
  end
end
