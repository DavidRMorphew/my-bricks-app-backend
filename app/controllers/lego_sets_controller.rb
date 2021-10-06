class LegoSetsController < ApplicationController

    def index
        lego_sets = LegoSet.all
        render json: LegoSetSerializer.new(lego_sets)
    end

    def owned_sets
        # lego_sets = LegoSet.where(owned: true)
        lego_sets = current_user.lego_sets
        render json: LegoSetSerializer.new(lego_sets)
    end
    
    def potential_builds
        strictParam = params[:strictParam]
        if strictParam == "notStrict"
            potential_build_lego_sets = LegoSet.potential_builds_regardless_of_color
        elsif strictParam == "strict"
            potential_build_lego_sets = LegoSet.potential_builds_strict_color_and_quantity
        end
        render json: LegoSetSerializer.new(potential_build_lego_sets)
    end

    def update
        lego_set = LegoSet.find_by(id: params[:id])
        # if owned_set = lego_set.owned_sets.where(user: current_user
            #  owned_set.destroy
        # else
            #  lego_set.owned_sets.create(user: current_user)
        # end
        owned_attribute_state = lego_set.owned
        if lego_set.update(owned: !owned_attribute_state)
            render json: LegoSetSerializer.new(lego_set)
        end
    end

end
