class SetPartSpecsController < ApplicationController
  def index
    lego_set = LegoSet.find_by(id: params[:lego_set_id])
    set_part_specs = lego_set.set_part_specs
    render json: SetPartSpecSerializer.new(set_part_specs)
  end
end
