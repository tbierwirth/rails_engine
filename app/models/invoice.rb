class Invoice < ApplicationRecord
  validates_presence_of :status

  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items
  has_many :transactions
  has_many :items, through: :invoice_items

  def self.most_revenue(limit = 5)
    select('invoices.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .joins(:invoice_items, :transactions)
    .merge(Transaction.unscoped.successful)
    .group('invoices.id')
    .order('revenue DESC')
    .limit(limit)
  end

  def find_transactions
    Transaction.where('transactions.invoice_id = ?', self).order('transactions.id')
  end

  def find_invoice_items
    InvoiceItem.where('invoice_items.invoice_id = ?', self).order('invoice_items.id')
  end

end
