class Api::V1::Invoices::TransactionsController < ApplicationController

  def index
    invoice = Invoice.find_by(find_params)
    render json: TransactionSerializer.new(invoice.find_transactions)
  end

  private

  def find_params
    params.permit(:id)
  end

end
