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

  def self.revenue_by_date(date)
    Invoice.joins(:invoice_items, :transactions)
            .where('transactions.result = ?', 'success')
            .where({invoices:{created_at: (date.to_date.all_day)}})
            .sum('invoice_items.quantity * invoice_items.unit_price')
  end

  def self.total_revenue(id)
    Merchant.joins(invoices: [:invoice_items, :transactions])
            .select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price)')
            .merge(Transaction.successful)
            .where('invoices.merchant_id = ?', id)
            .group('merchants.id')
  end

  def total_revenue
    invoices.joins(:invoice_items, :transactions)
            .merge(Transaction.successful)
            .sum('invoice_items.quantity * invoice_items.unit_price')
  end

  def revenue_by_date(date)
    invoices.joins(:invoice_items, :transactions)
            .merge(Transaction.successful)
            .where({invoices:{created_at: (date.to_date.all_day)}})
            .sum('invoice_items.quantity * invoice_items.unit_price')
  end

  def favorite_customer
    invoices.joins(:transactions)
            .merge(Transaction.successful)
            .select('invoices.customer_id, COUNT(invoices.customer_id) AS customer_count')
            .group('invoices.customer_id')
            .order('customer_count DESC')
            .first
  end
end
