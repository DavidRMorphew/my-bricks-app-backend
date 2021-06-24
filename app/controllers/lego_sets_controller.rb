class LegoSetsController < ApplicationController

    def index
        lego_sets = LegoSet.all
        render json: lego_sets.to_json(except: [:created_at, :updated_at])
    end
end
