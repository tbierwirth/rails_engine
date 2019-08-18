class Api::V1::Items::RandomController < ApplicationController

  def show
    id = Item.pluck(:id).sample
    render json: ItemSerializer.new(Item.find(id))
  end

end
