class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    revenue = Merchant.revenue_by_date(params[:date])
    render json: {"data" => {"attributes" => {'total_revenue' => '%.2f' % (revenue.to_f / 100)}}}
  end

  def show
    merchant = Merchant.find(params[:id])
    if params[:date]
      revenue = merchant.revenue_by_date(params[:date])
    else
      revenue = merchant.total_revenue
    end
    render json: {"data" => {"attributes" => {'revenue' => '%.2f' % (revenue.to_f / 100)}}}
  end

end
