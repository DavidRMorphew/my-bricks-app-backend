class Api < ApplicationRecord
    @@base_url = "https://rebrickable.com/api/v3/lego"

    def self.fetch_theme_by_id(theme_id)
        url = "#{@@base_url}/themes/#{theme_id}/?key=#{ENV["LEGO_API_KEY"]}"
        uri = URI(url)

        resp = Net::HTTP.get(uri)

        theme = JSON.parse(resp)
        Theme.create(theme_number: theme["id"], name: theme["name"])
    end
end