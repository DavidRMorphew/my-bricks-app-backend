class LegoSetsController < ApplicationController

    def index
        lego_sets = LegoSet.all
        render json: LegoSetSerializer.new(lego_sets)
    end

    def owned_sets
        lego_sets = LegoSet.where(owned: true)
        render json: LegoSetSerializer.new(lego_sets)
    end

    def update
        lego_set = LegoSet.find_by(id: params[:id])
        if lego_set.update(owned: true)
            render json: LegoSetSerializer.new(lego_set)
        end
    end
end
