class Api::V1::Merchants::FavoriteCustomerController < ApplicationController

  def show
    merchant = Merchant.find(params[:id])
    customer = merchant.favorite_customer
    render json: {"data" => {"attributes" => {'id' => customer["customer_id"]}}}
  end

end
