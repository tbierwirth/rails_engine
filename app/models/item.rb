class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates_presence_of :name,
                        :description,
                        :unit_price
  default_scope { order(id: :asc) }

  def self.most_revenue(limit)
    select('items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS item_revenue')
    .joins(:invoice_items)
    .group('items.id')
    .order('item_revenue DESC')
    .limit(limit)
  end

  def self.most_items(limit)
    select('items.*, SUM(invoice_items.quantity) AS amount_sold')
    .joins(:invoice_items)
    .group('items.id')
    .order('amount_sold DESC')
    .limit(limit)
  end

  def best_day
    invoices
    .select('sum(invoice_items.quantity) AS amt_sold, invoices.created_at::date AS best_day')
    .group('best_day')
    .group(:id)
    .order('amt_sold DESC')
    .order('best_day DESC')
    .limit(1)
  end
end
