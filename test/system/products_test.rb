require "application_system_test_case"

class ProductsTest < ApplicationSystemTestCase
  setup do
    @product = products(:one)
  end

  test "visiting the index" do
    visit products_url
    assert_selector "h1", text: "Inventory Products"
  end

  test "creating a Product" do
    visit products_url
    click_on "Add Product"

    fill_in "Name", with: "System Test Product"
    fill_in "Description", with: "Created via system test"
    fill_in "Price", with: "99.99"
    fill_in "Quantity", with: "10"
    fill_in "Low stock threshold", with: "5"
    
    click_on "Create Product"

    assert_text "Product was successfully created"
    assert_text "System Test Product"
  end
end
