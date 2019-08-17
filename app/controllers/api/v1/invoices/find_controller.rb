class Api::V1::Invoices::FindController < ApplicationController

  def index
    render json: InvoiceSerializer.new(Invoice.where(find_params))
  end

  def show
    render json: InvoiceSerializer.new(Invoice.find_by(find_params))
  end

  private

  def find_params
    params.permit(:id, :name, :status, :merchant_id, :customer_id)
  end

end
