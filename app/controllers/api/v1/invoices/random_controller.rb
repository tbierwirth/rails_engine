class Api::V1::Invoices::RandomController < ApplicationController

  def show
    id = Invoice.pluck(:id).sample
    render json: InvoiceSerializer.new(Invoice.find(id))
  end

end
