class CreateOwnedSets < ActiveRecord::Migration[6.0]
  def change
    create_table :owned_sets do |t|
      t.integer :lego_set_id
      t.integer :user_id

      t.timestamps
    end
  end
end
