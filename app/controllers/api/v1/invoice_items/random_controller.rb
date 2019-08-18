class Api::V1::InvoiceItems::RandomController < ApplicationController

  def show
    id = InvoiceItem.pluck(:id).sample
    render json: InvoiceItemSerializer.new(InvoiceItem.find(id))
  end

end
