class LegoSetsController < ApplicationController

    def index
        lego_sets = LegoSet.all
        render json: LegoSetSerializer.new(lego_sets)
    end
end
