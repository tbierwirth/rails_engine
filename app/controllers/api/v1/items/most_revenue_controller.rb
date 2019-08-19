class Api::V1::Items::MostRevenueController < ApplicationController

  def index
    items = Item.unscoped.most_revenue(params[:quantity])
    render json: ItemSerializer.new(items)
  end

end
