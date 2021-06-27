class AddPotentialBuildStrictToLegoSets < ActiveRecord::Migration[6.0]
  def change
    add_column :lego_sets, :potential_build_strict, :boolean
  end
end
