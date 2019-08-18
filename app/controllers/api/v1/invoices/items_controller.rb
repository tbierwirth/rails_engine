class Api::V1::Invoices::ItemsController < ApplicationController

  def index
    invoice = Invoice.find_by(find_params)
    render json: ItemSerializer.new(invoice.items)
  end

  private

  def find_params
    params.permit(:id)
  end

end
