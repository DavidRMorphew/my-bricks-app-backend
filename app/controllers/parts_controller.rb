class PartsController < ApplicationController
  def index
    lego_set = LegoSet.find_by(id: params[:lego_set_id])
    parts = lego_set.parts
    render json: PartSerializer.new(parts)
  end
end
