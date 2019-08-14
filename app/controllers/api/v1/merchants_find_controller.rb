class Api::V1::MerchantsFindController < ApplicationController

  def show
    render json: MerchantSerializer.new(Merchant.find_by(find_params))
  end

  private

  def find_params
    params.permit(:id, :name, :created_at, :updated_at)
  end

end
