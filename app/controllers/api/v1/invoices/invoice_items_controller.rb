class Api::V1::Invoices::InvoiceItemsController < ApplicationController

  def index
    invoice = Invoice.find_by(find_params)
    render json: InvoiceItemSerializer.new(invoice.find_invoice_items)
  end

  private

  def find_params
    params.permit(:id)
  end

end
