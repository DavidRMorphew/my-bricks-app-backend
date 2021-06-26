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

    def array_of_parts_and_quantity_objects_by_strict_color_match(strict_color_match_ary = [])
        self.match_parts_of_set.each do |match_part|
            if prev_entry = strict_color_match_ary.detect {|owned_part_quantity_obj| owned_part_quantity_obj[:part] == match_part}
                prev_entry[:part_quantity] += self.part_quantity_in_set_by_part(match_part)
            else
                owned_part_quantity_obj = {part: match_part, part_quantity: self.part_quantity_in_set_by_part(match_part)}
                strict_color_match_ary.push(owned_part_quantity_obj)
            end
        end
        strict_color_match_ary
    end
end
