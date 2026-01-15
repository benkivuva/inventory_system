class Product < ApplicationRecord
  has_one_attached :image
  has_many :stock_movements, dependent: :destroy

  after_create :log_creation
  after_update :log_stock_change, if: :saved_change_to_quantity?
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

  private

  def log_stock_change
    previous_qty = saved_change_to_quantity[0].to_i
    new_qty = saved_change_to_quantity[1].to_i
    diff = new_qty - previous_qty

    action_type = diff.positive? ? "addition" : "reduction"
    reason = "Quantity changed from #{previous_qty} to #{new_qty}"

    stock_movements.create(
      amount: diff,
      action: action_type,
      notes: reason
    )
  end

  def log_creation
    return if quantity.zero?

    stock_movements.create(
      amount: quantity,
      action: "initial",
      notes: "Initial stock of #{quantity}"
    )
  end
end
