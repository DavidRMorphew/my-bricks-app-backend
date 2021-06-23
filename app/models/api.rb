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
end