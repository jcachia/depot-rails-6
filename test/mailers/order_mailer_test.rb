require 'test_helper'

class OrderMailerTest < ActionMailer::TestCase
  test "received" do
    mail = OrderMailer.received(orders(:one))
    assert_equal "Rails 6 BookStore Order Confirmation", mail.subject
    assert_equal [orders(:one).email], mail.to
    assert_equal ["orders@rails6bookstore.com"], mail.from
    assert_match /1 x A Ruby Book/, mail.body.encoded
  end

  test "shipped" do
    mail = OrderMailer.shipped(orders(:one))
    assert_equal "Rails 6 BookStore Order Shipped!", mail.subject
    assert_equal [orders(:one).email], mail.to
    assert_equal ["orders@rails6bookstore.com"], mail.from
    assert_match /<td>A Ruby Book<\/td>/, mail.body.encoded
  end

end
