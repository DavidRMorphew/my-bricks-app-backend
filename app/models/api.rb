class Api < ApplicationRecord
    @@base_url = "https://rebrickable.com/api/v3/lego"

    def self.find_or_create_theme_by_theme_num(theme_id)
        theme = (Theme.find_by(theme_number: theme_id) || self.fetch_theme_by_theme_num(theme_id))
    end

    def self.fetch_theme_by_theme_num(theme_id)
        url = "#{@@base_url}/themes/#{theme_id}/?key=#{ENV["LEGO_API_KEY"]}"
        uri = URI(url)

        resp = Net::HTTP.get(uri)

        theme = JSON.parse(resp)
        Theme.create(theme_number: theme["id"], name: theme["name"])
    end

    def self.find_or_create_set_by_set_num(set_num, theme = nil) # optional theme argument
        lego_set = (LegoSet.find_by(set_number: set_num) || self.fetch_set_by_set_num(set_num, theme = nil))
    end
    
    def self.fetch_set_by_set_num(set_num, theme = nil) # optional theme argument
        url = "#{@@base_url}/sets/#{set_num}/?key=#{ENV["LEGO_API_KEY"]}"
        uri = URI(url)

        resp = Net::HTTP.get(uri)

        data = JSON.parse(resp)
        if !data.empty?
            theme ||= self.find_or_create_theme_by_theme_num(data["theme_id"])
            lego_set = theme.lego_sets.create(set_number: data["set_num"], year: data["year"], image_url: data["set_img_url"], name: data["name"], instructions_url: "https://rebrickable.com/instructions/#{set_num}")
        end
    end


end