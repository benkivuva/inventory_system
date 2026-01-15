class Product < ApplicationRecord
  has_one_attached :image
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :low_stock_threshold, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :low_stock, -> { where("quantity <= low_stock_threshold") }

  def low_stock?
    quantity <= low_stock_threshold
  end

  def out_of_stock?
    quantity.zero?
  end

  def in_stock?
    quantity.positive?
  end
end
