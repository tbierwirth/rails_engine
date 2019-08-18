class Api::V1::Transactions::RandomController < ApplicationController

  def show
    id = Transaction.pluck(:id).sample
    render json: TransactionSerializer.new(Transaction.find(id))
  end

end
