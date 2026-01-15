class StockMovement < ApplicationRecord
  belongs_to :product

  validates :amount, presence: true, numericality: { other_than: 0 }
  validates :action, presence: true
end
