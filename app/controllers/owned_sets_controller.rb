class OwnedSetsController < ApplicationController
  def index
    owned_sets = current_user.owned_sets
    render json: OwnedSetsSerializer.new(owned_sets)
  end

  def create
  end

  def destroy
  end
end
