require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  setup do
    @order = orders(:one)
  end

  test "visiting the index" do
    visit orders_url
    assert_selector "h1", text: "Orders"
  end

  test "check routing number" do
    visit store_index_url

    click_on 'Add to Cart', match: :first

    click_on 'Checkout'

    fill_in 'order_name', with: 'Order Name'
    fill_in 'order_address', with: '123 Order St.'
    fill_in 'order_email', with: 'order@shopper.com'

    assert_no_selector '#order_routing_number'

    select 'Check', from: 'Pay Type'

    assert_selector '#order_routing_number'
  end

  test "destroying a Order" do
    visit orders_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Order was successfully destroyed"
  end
end
