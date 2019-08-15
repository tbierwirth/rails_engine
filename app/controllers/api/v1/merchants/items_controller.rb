class Api::V1::Merchants::ItemsController < ApplicationController

  def index
    merchant = Merchant.find_by(find_params)
    render json: ItemSerializer.new(merchant.find_items)
  end

  private

  def find_params
    params.permit(:id, :name)
  end

end
