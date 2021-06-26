class LegoSetsController < ApplicationController

    def index
        lego_sets = LegoSet.all
        render json: LegoSetSerializer.new(lego_sets)
    end

    def owned_sets
        lego_sets = LegoSet.where(owned: true)
        render json: LegoSetSerializer.new(lego_sets)
    end
end
