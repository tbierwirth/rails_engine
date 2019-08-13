class Api::V1::MerchantsFindController < ApplicationController

  def show
    render json: MerchantSerializer.new(Merchant.find_by(name: params[:name]))
  end

end
