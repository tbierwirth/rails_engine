class Api::V1::InvoiceItems::InvoiceController < ApplicationController

  def show
    invoice_item = InvoiceItem.find_by(find_params)
    render json: InvoiceSerializer.new(invoice_item.invoice)
  end

  private

  def find_params
    params.permit(:id)
  end

end
