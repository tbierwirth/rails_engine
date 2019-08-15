class Api::V1::Merchants::InvoicesController < ApplicationController

  def index
    merchant = Merchant.find_by(find_params)
    render json: InvoiceSerializer.new(merchant.find_invoices)
  end

  private

  def find_params
    params.permit(:id, :name)
  end

end
