class Api::V1::Invoices::MerchantController < ApplicationController

  def show
    invoice = Invoice.find_by(find_params)
    render json: MerchantSerializer.new(Merchant.find(invoice.merchant_id))
  end

  private

  def find_params
    params.permit(:id)
  end

end
