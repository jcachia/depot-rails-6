require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  include ActiveJob::TestHelper # provides perform_enqueued_jobs.

  setup do
    @order = orders(:one)
  end

  test "visiting the index" do
    visit orders_url
    assert_selector "h1", text: "Orders"
  end

  test "check for correct dynamic fields for pay types" do
    # Make sure there are no lingering orders from prior tests.
    LineItem.delete_all
    Order.delete_all

    check_fields = %w{ #order_routing_number #order_account_number }
    credit_card_fields = %w{ #order_credit_card_number #order_expiration_date }
    po_fields = %w{ #order_po_number }
    all_selectors = check_fields + credit_card_fields + po_fields

    visit store_index_url

    click_on 'Add to Cart', match: :first

    click_on 'Checkout'

    fill_in 'order_name', with: 'Order Name'
    fill_in 'order_address', with: '123 Order St.'
    fill_in 'order_email', with: 'order@shopper.com'

    # no dynamic selectors present at first...
    all_selectors.each do |selector|
      assert_no_selector selector
    end

    select 'Check', from: 'Pay Type'
    check_fields.each do |selector|
      assert_selector selector
    end
    (credit_card_fields + po_fields).each do |selector|
      assert_no_selector selector
    end

    fill_in "Routing Number", with: "12345"
    fill_in "Account Number", with: "98765"

    # Initiating the action click button inside the perform_enqued_jobs block will process the job thats queued from the action.
    perform_enqueued_jobs do
      click_button "Place Order"
    end

    orders = Order.all
    assert_equal 1, orders.size

    order = orders.first

    assert_equal "Order Name",        order.name
    assert_equal "123 Order St.",     order.address
    assert_equal "order@shopper.com", order.email
    assert_equal "Check",             order.pay_type
    assert_equal 1,                   order.line_items.size

    mail = ActionMailer::Base.deliveries.last # Mail not sent in test; instead found in this array.
    assert_equal ["order@shopper.com"], mail.to
    assert_equal "BookStore Orders <orders@rails6bookstore.com>", mail[:from].value
    assert_equal "Rails 6 BookStore Order Confirmation", mail.subject

    # Will need a refactor here.
    # select 'Credit Card', from: 'Pay Type'
    # credit_card_fields.each do |selector|
    #   assert_selector selector
    # end
    # (check_fields + po_fields).each do |selector|
    #   assert_no_selector selector
    # end
    #
    # select 'Purchase Order', from: 'Pay Type'
    # po_fields.each do |selector|
    #   assert_selector selector
    # end
    # (check_fields + credit_card_fields).each do |selector|
    #   assert_no_selector selector
    # end

  end

  test "destroying a Order" do
    visit orders_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Order was successfully destroyed"
  end
end
