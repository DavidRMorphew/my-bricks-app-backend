class SetPartSpecsController < ApplicationController
  def index
    lego_set = LegoSet.find_by(id: params[:lego_set_id])
    binding.pry
  end
end
