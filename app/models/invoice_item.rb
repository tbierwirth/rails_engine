class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  validates_presence_of :quantity,
                        :unit_price

  def self.random
    InvoiceItem.order("RANDOM()").limit(1)
  end
end
