class Part < ApplicationRecord
    belongs_to :part_category
    has_many :set_part_specs
    has_many :lego_sets, through: :set_part_specs
end
