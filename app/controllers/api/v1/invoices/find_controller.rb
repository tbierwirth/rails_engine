class Api::V1::Invoices::FindController < ApplicationController

  def index
    render json: InvoiceSerializer.new(Invoice.where(find_params).order(id: :asc))
  end

  def show
    render json: InvoiceSerializer.new(Invoice.find_by(find_params))
  end

  private

  def find_params
    params.permit(:id, :status, :merchant_id, :customer_id, :created_at, :updated_at)
  end

end
