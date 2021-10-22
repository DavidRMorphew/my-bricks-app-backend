class OwnedSetsController < ApplicationController
  def index
    owned_sets = current_user.owned_sets
    render json: OwnedSetsSerializer.new(owned_sets)
  end

  def create
    owned_set = current_user.owned_sets.build(lego_set_id: params[:legoSetId])
    if owned_set.save
      render json: OwnedSetsSerializer.new(owned_set)
    else
      render json: { error: 'failed to add set to owned'}, status: :not_acceptable
    end
  end

  def destroy
  end
end
