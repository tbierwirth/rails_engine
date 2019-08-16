class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :items
  validates_presence_of :name

  def self.most_revenue(amount)
    Merchant.joins(invoices: [:invoice_items, :transactions])
            .select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
            .merge(Transaction.successful)
            .group('merchants.id')
            .order('revenue DESC')
            .limit(amount)
  end

  def self.most_items(amount)
    Merchant.joins(invoices: [:invoice_items, :transactions])
            .select('merchants.*, SUM(invoice_items.quantity) AS count')
            .merge(Transaction.successful)
            .group('merchants.id')
            .order('count DESC')
            .limit(amount)
  end

  def self.revenue(date)
    Merchant.joins(invoices: [:invoice_items, :transactions])
            .select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price)')
            .merge(Transaction.successful)
            .where({invoice_items:{created_at: (date.to_date.all_day)}})
            group('merchants.id')
  end
end
