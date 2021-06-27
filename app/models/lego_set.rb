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

    def array_parts_quantity_regardless_of_color(match_ary = [])
        self.match_parts_of_set.each do |match_part|
            if prev_entry = match_ary.detect {|owned_part_quantity_obj| owned_part_quantity_obj[:part_number] == match_part.part_number}
                prev_entry[:part_quantity] += self.part_quantity_in_set_by_part(match_part)
            else
                owned_part_quantity_obj = {part_number: match_part.part_number, part_quantity: self.part_quantity_in_set_by_part(match_part)}
                match_ary.push(owned_part_quantity_obj)
            end
        end
        match_ary
    end

    def self.array_of_parts_and_quantity_objects_by_strict_color_owned
        strict_color_match_ary = []
        self.owned_sets.each do |set|
            set.array_of_parts_and_quantity_objects_by_strict_color_match(strict_color_match_ary)
        end
        strict_color_match_ary
    end

    def self.array_of_parts_and_quantity_objects_regardless_of_color_owned
        match_ary = [] 
        self.owned_sets.each do |set|
            set.array_parts_quantity_regardless_of_color(match_ary)
        end
        match_ary
    end

    def self.potential_builds_strict_color_filtered_by_part_types(owned_parts_quantity_ary = [])
        if owned_parts_quantity_ary.empty?
            owned_parts_quantity_ary = self.array_of_parts_and_quantity_objects_by_strict_color_owned
        end
        owned_parts_filter_ary = owned_parts_quantity_ary.map {|part_obj| part_obj[:part]}
        sets_parts_match = self.select do |set|
            !set.owned && !set.match_parts_of_set.empty? && (set.match_parts_of_set - owned_parts_filter_ary).empty?
        end
    end

    def self.potential_builds_regardless_of_color_filtered_by_part_types(owned_parts_quantity_ary = [])
        if owned_parts_quantity_ary.empty?
            owned_parts_quantity_ary = self.array_of_parts_and_quantity_objects_regardless_of_color_owned
        end
        owned_parts_filter_ary = owned_parts_quantity_ary.map {|part_obj| part_obj[:part_number]}
        sets_parts_match = self.select do |set|
            !set.owned && !set.match_parts_of_set.empty? && (set.match_parts_of_set.map {|part| part.part_number} - owned_parts_filter_ary).empty?
        end
    end

    def self.potential_builds_strict_color_and_quantity
        self.update_all(potential_build_strict: false)
        owned_parts_quantity_ary = self.array_of_parts_and_quantity_objects_by_strict_color_owned
        filtered_sets_by_parts = self.potential_builds_strict_color_filtered_by_part_types(owned_parts_quantity_ary)
    
        results = []
        filtered_sets_by_parts.each do |set|
            if set.array_of_parts_and_quantity_objects_by_strict_color_match.all? do |part_obj|
                part_obj[:part_quantity] <= owned_parts_quantity_ary.detect{|owned_part| owned_part[:part] == part_obj[:part]}[:part_quantity]
                end
                set.update(potential_build_strict: true)
                results << set
            end
        end
        results
    end

    def self.potential_builds_regardless_of_color
        self.update_all(potential_build: false)
        owned_parts_quantity_ary = self.array_of_parts_and_quantity_objects_regardless_of_color_owned
        filtered_sets_by_parts = self.potential_builds_regardless_of_color_filtered_by_part_types(owned_parts_quantity_ary)

        results = []
        filtered_sets_by_parts.each do |set|
            if set.array_parts_quantity_regardless_of_color.all? do |part_obj|
                    part_obj[:part_quantity] <= owned_parts_quantity_ary.detect{|owned_part| owned_part[:part_number] == part_obj[:part_number]}[:part_quantity]
                end
                set.update(potential_build: true)
                results << set
            end
        end
        results
        # results = filtered_sets_by_parts.select do |set|
        #     set.array_parts_quantity_regardless_of_color.all? do |part_obj|
        #         part_obj[:part_quantity] <= owned_parts_quantity_ary.detect{|owned_part| owned_part[:part_number] == part_obj[:part_number]}[:part_quantity]
        #     end
        # end
    end
end
