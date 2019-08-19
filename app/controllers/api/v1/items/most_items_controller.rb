class Api::V1::Items::MostItemsController < ApplicationController

  def index
    items = Item.unscoped.most_items(params[:quantity])
    render json: ItemSerializer.new(items)
  end

end
