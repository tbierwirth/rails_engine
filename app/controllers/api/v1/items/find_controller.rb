class Api::V1::Items::FindController < ApplicationController

  def index
    render json: ItemSerializer.new(Item.where(find_params).order(id: :asc))
  end

  def show
    render json: ItemSerializer.new(Item.find_by(find_params))
  end

  private

  def find_params
    params[:unit_price] = (params[:unit_price].to_f*100).round(0) if params[:unit_price]
    params.permit(:id, :name, :merchant_id, :description, :unit_price, :created_at, :updated_at)
  end

end
