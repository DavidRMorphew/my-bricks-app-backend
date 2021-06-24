class Api < ApplicationRecord
    @@base_url = "https://rebrickable.com/api/v3/lego"

    def self.find_or_create_theme_by_theme_num(theme_num)
        theme = (Theme.find_by(theme_number: theme_num) || self.fetch_theme_by_theme_num(theme_num))
    end

    def self.fetch_theme_by_theme_num(theme_num)
        sleep(1) # To avoid throttling by Api site
        url = "#{@@base_url}/themes/#{theme_num}/?key=#{ENV["LEGO_API_KEY"]}"
        uri = URI(url)

        resp = Net::HTTP.get(uri)

        theme = JSON.parse(resp)
        Theme.create(theme_number: theme["id"], name: theme["name"])
    end

    def self.find_or_create_set_by_set_num(set_num, theme = nil) # optional theme argument
        lego_set = (LegoSet.find_by(set_number: set_num) || self.fetch_set_by_set_num(set_num, theme = nil))
    end
    
    def self.fetch_set_by_set_num(set_num, theme = nil) # optional theme argument
        sleep(1) # To avoid throttling by Api site
        url = "#{@@base_url}/sets/#{set_num}/?key=#{ENV["LEGO_API_KEY"]}"
        uri = URI(url)

        resp = Net::HTTP.get(uri)

        data = JSON.parse(resp)
        if !data.empty?
            theme ||= self.find_or_create_theme_by_theme_num(data["theme_id"])
            lego_set = theme.lego_sets.create(set_number: data["set_num"], year: data["year"], image_url: data["set_img_url"], name: data["name"], instructions_url: "https://rebrickable.com/instructions/#{set_num}", total_bricks: data["num_parts"])
        end
    end

    def self.find_or_create_part_category_by_num(part_category_num)
        part_category = (PartCategory.find_by(category_number: part_category_num) || self.fetch_part_category_by_num(part_category_num))
    end

    def self.fetch_part_category_by_num(part_category_num)
        sleep(1) # To avoid throttling by Api site
        url = "#{@@base_url}/part_categories/#{part_category_num}/?key=#{ENV["LEGO_API_KEY"]}"
        uri = URI(url)

        resp = Net::HTTP.get(uri)
        data = JSON.parse(resp)
        part_category = PartCategory.create(category_number: data["id"], name: data["name"])
    end

    def self.find_set_with_parts_or_create(set_num, theme = nil) # not sure this optional argument is needed
        lego_set = self.find_or_create_set_by_set_num(set_num, theme = nil)
        if lego_set.parts.empty?
            sleep(1) # To avoid throttling by Api site
            self.fetch_set_and_parts_of_set(lego_set)
        else
            lego_set
        end
    end

    def self.fetch_set_and_parts_of_set(lego_set)
        set_num = lego_set.set_number
        url = "#{@@base_url}/sets/#{set_num}/parts/?key=#{ENV["LEGO_API_KEY"]}&page_size=1000"
        uri = URI(url)
        
        resp = Net::HTTP.get(uri)
        data = JSON.parse(resp)
        parts = data["results"]

        parts.each do |part|
            p = part["part"]
            part_category = self.find_or_create_part_category_by_num(p["part_cat_id"])

            not_for_match_category_numbers = [13, 17, 27, 28, 38, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65]
        
            for_match_value = (not_for_match_category_numbers.include?(part_category.category_number.to_i)) ? false : true

            if set_part = Part.find_by(part_number: p["part_num"], name: p["name"], color: part["color"]["name"])
                if !lego_set.parts.include?(set_part)
                    lego_set.parts.push(set_part)
                # else
                #     set_part
                end
            else
                set_part = lego_set.parts.create(part_number: p["part_num"], name: p["name"], color: part["color"]["name"], part_category: part_category, for_match: for_match_value, image_url: p["part_img_url"])
            end
            set_part_spec = lego_set.set_part_specs.where(part: set_part).first
            if !set_part_spec.part_quantity || (part["quantity"] > set_part_spec.part_quantity)
                set_part_spec.update(part_quantity: part["quantity"])
            end
        end
    end

    def self.fetch_sets_by_theme_num(theme_num)
        url = "#{@@base_url}/sets/?theme_id=#{theme_num}"
        uri = URI(url)
        theme = self.find_or_create_theme_by_theme_num(theme_num)

        Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
            request = Net::HTTP::Get.new uri
            request["Authorization"] = "key #{ENV["LEGO_API_KEY"]}"

            response = http.request(request).body
            data = JSON.parse(response)
           
            sets = data["results"]
            sets.each do |set|
                self.find_set_with_parts_or_create(set["set_num"], theme)
            end
        end
    end
end