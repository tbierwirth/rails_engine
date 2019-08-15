class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :items
  validates_presence_of :name

  def find_items
    Item.where('items.merchant_id = ?', self).order('items.id')
  end

  def find_invoices
    Invoice.where('invoices.merchant_id = ?', self).order('invoices.id')
  end
end
