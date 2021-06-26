class LegoSet < ApplicationRecord
    belongs_to :theme
    has_many :set_part_specs
    has_many :parts, through: :set_part_specs

    def theme_name
        self.theme.name
    end

    def self.owned_sets
        self.all.where(owned: true)
    end

    def match_parts_of_set
        self.parts.where(for_match: true)
    end

    def part_quantity_in_set_by_part(part)
        self.set_part_specs.find_by(part: part).part_quantity
    end
end
