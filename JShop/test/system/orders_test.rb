require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  setup do
    @order = orders(:one)
  end

  test "visiting the index" do
    visit orders_url
    assert_selector "h1", text: "Orders"
  end

  test "creating a Order" do
    visit orders_url
    click_on "New Order"

    fill_in "Deal sum", with: @order.deal_sum
    fill_in "Delivery address", with: @order.delivery_address
    fill_in "Delivery name", with: @order.delivery_name
    fill_in "Delivery phone", with: @order.delivery_phone
    fill_in "Order status", with: @order.order_status
    fill_in "User", with: @order.user_id
    click_on "Create Order"

    assert_text "Order was successfully created"
    click_on "Back"
  end

  test "updating a Order" do
    visit orders_url
    click_on "Edit", match: :first

    fill_in "Deal sum", with: @order.deal_sum
    fill_in "Delivery address", with: @order.delivery_address
    fill_in "Delivery name", with: @order.delivery_name
    fill_in "Delivery phone", with: @order.delivery_phone
    fill_in "Order status", with: @order.order_status
    fill_in "User", with: @order.user_id
    click_on "Update Order"

    assert_text "Order was successfully updated"
    click_on "Back"
  end

  test "destroying a Order" do
    visit orders_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Order was successfully destroyed"
  end
end
