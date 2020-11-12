require "application_system_test_case"

class CartsTest < ApplicationSystemTestCase
  setup do
    @cart = carts(:one)
  end

  test "visiting the index" do
    visit carts_url
    assert_selector "h1", text: "Carts"
  end

  test "showing the cart when an item added" do
    visit store_index_url
    # no cart visible (present, but hidden)
    assert_selector '#cart', visible: :false

    click_on 'Add to Cart', match: :first
    # cart present with all buttons
    assert_selector '#cart'
    assert_selector 'input[value="Remove item"]'
    assert_selector 'input[value="Empty cart"]'
    assert_selector 'input[value="Checkout"]'
    # remove only the checkout button when taken to order screen.
    click_on 'Checkout'
    assert_selector '#cart'
    assert_selector 'input[value="Remove item"]'
    assert_selector 'input[value="Empty cart"]'
    assert_no_selector 'input[value="Checkout"]'
    # emptying the cart hides it
    page.accept_confirm do
      click_on 'Empty cart'
    end
    assert_selector '#cart', visible: :false

  end

  # test "creating a Cart" do
  #   visit carts_url
  #   click_on "New Cart"
  #
  #   click_on "Create Cart"
  #
  #   assert_text "Cart was successfully created"
  #   click_on "Back"
  # end

  # test "updating a Cart" do
  #   visit carts_url
  #   click_on "Edit", match: :first
  #
  #   click_on "Update Cart"
  #
  #   assert_text "Cart was successfully updated"
  #   click_on "Back"
  # end

  # test "destroying a Cart" do
  #   visit carts_url
  #   page.accept_confirm do
  #     click_on "Destroy", match: :first
  #   end
  #
  #   assert_text "Cart was successfully destroyed"
  # end
end
