require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
    # Ensure DashboardStats can run (requires products)
  end

  test "should get index" do
    get products_url
    assert_response :success
  end

  test "should get new" do
    get new_product_url
    assert_response :success
  end

  test "should create product" do
    assert_difference("Product.count") do
      post products_url, params: { product: { name: "New Product", description: "Desc", price: 10, quantity: 5, low_stock_threshold: 2 } }
    end

    assert_redirected_to products_path
  end

  test "should create product with zero quantity" do
    assert_difference("Product.count") do
      post products_url, params: { product: { name: "Zero Stock Product", description: "Desc", price: 10, quantity: 0, low_stock_threshold: 2 } }
    end

    assert_redirected_to products_path
    follow_redirect!
    assert_select "div", text: /Zero Stock Product/
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_url(@product)
    assert_response :success
  end

  test "should update product" do
    patch product_url(@product), params: { product: { name: "Updated Name" } }
    assert_redirected_to products_path
  end

  test "should destroy product" do
    assert_difference("Product.count", -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_path
  end

  test "should adjust stock via patch" do
    patch adjust_stock_product_path(@product), params: { adjustment: "increment" }, headers: { "Accept" => "text/vnd.turbo-stream.html" }
    assert_response :success
    @product.reload
    assert_equal 11, @product.quantity # Fixture :one has 10
  end

  test "should get history" do
    get history_product_path(@product)
    assert_response :success
  end
end
