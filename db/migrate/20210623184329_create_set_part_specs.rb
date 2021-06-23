class CreateSetPartSpecs < ActiveRecord::Migration[6.0]
  def change
    create_table :set_part_specs do |t|
      t.integer :lego_set_id
      t.integer :part_id
      t.integer :part_quantity

      t.timestamps
    end
  end
end
