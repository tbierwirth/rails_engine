class Api::V1::Transactions::FindController < ApplicationController

  def index
    render json: TransactionSerializer.new(Transaction.where(find_params).order(id: :asc))
  end

  def show
    render json: TransactionSerializer.new(Transaction.find_by(find_params))
  end

  private

  def find_params
    params.permit(:id, :invoice_id, :result, :credit_card_number, :created_at, :updated_at)
  end

end
