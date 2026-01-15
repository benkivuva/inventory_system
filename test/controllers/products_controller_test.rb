require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
  end

  test "should get index" do
    get products_path
    assert_response :success
  end

  test "should get new" do
    get new_product_path
    assert_response :success
  end

  test "should create product" do
    assert_difference("Product.count") do
      post products_path, params: { product: { name: "New Widget", description: "Foo", price: 10, quantity: 10, low_stock_threshold: 5 } }
    end

    assert_redirected_to products_url
  end

  test "should update product" do
    patch product_path(@product), params: { product: { name: "Updated Name" } }
    assert_redirected_to products_url
    @product.reload
    assert_equal "Updated Name", @product.name
  end

  test "should destroy product" do
    assert_difference("Product.count", -1) do
      delete product_path(@product)
    end

    assert_redirected_to products_url
  end
end
