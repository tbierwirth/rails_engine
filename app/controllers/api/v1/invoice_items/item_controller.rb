class Api::V1::InvoiceItems::ItemController < ApplicationController

  def show
    invoice_item = InvoiceItem.find_by(find_params)
    render json: ItemSerializer.new(invoice_item.item)
  end

  private

  def find_params
    params.permit(:id)
  end

end
