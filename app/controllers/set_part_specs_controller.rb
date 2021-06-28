class SetPartSpecsController < ApplicationController
  def index
    lego_set = LegoSet.find_by(id: params[:lego_set_id])
    lego_set.set_part_specs
    binding.pry
  end
end
