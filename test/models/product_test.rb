require "test_helper"

class ProductTest < ActiveSupport::TestCase
  def setup
    @product = Product.new(
      name: "Test Product",
      description: "A valid test product",
      price: 10.00,
      quantity: 50,
      low_stock_threshold: 10
    )
  end

  test "should be valid with valid attributes" do
    assert @product.valid?
  end

  test "name should be present" do
    @product.name = ""
    assert_not @product.valid?
  end

  test "price should be non-negative" do
    @product.price = -1
    assert_not @product.valid?
  end

  test "quantity should be integer and non-negative" do
    @product.quantity = -1
    assert_not @product.valid?
    @product.quantity = 1.5
    assert_not @product.valid?
  end

  test "should correctly identify low stock" do
    @product.quantity = 9
    @product.low_stock_threshold = 10
    assert @product.low_stock?
  end

  test "should correctly identify out of stock" do
    @product.quantity = 0
    assert @product.out_of_stock?
  end

  test "should correctly identify in stock" do
    @product.quantity = 20
    @product.low_stock_threshold = 10
    assert @product.in_stock?
  end
end
