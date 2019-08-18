class Api::V1::InvoiceItems::FindController < ApplicationController

  def index
    render json: InvoiceItemSerializer.new(InvoiceItem.where(find_params).order(id: :asc))
  end

  def show
    render json: InvoiceItemSerializer.new(InvoiceItem.find_by(find_params))
  end

  private

  def find_params
    params[:unit_price] = (params[:unit_price].to_f*100).round(0) if params[:unit_price]
    params.permit(:id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at)
  end

end
