class Api::V1::Invoices::CustomerController < ApplicationController

  def show
    invoice = Invoice.find_by(find_params)
    render json: CustomerSerializer.new(Customer.find(invoice.customer_id))
  end

  private

  def find_params
    params.permit(:id)
  end

end
