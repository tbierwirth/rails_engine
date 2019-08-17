class Transaction < ApplicationRecord
  validates_presence_of :credit_card_number,
                        :result

  belongs_to :invoice

  # default_scope { order(id: :asc) }
  scope :successful, -> { where(result: "success") }
  scope :unsuccessful, -> { where(result: "failed") }

  def self.trans_by_customer(customer_id)
    joins(:invoice).where("invoices.customer_id = #{customer_id}")
  end
end
