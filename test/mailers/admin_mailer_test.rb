require 'test_helper'

class AdminMailerTest < ActionMailer::TestCase
  test "notify_error" do
    mail = AdminMailer.notify_error(Exception.new("this is a problem"))
    assert_equal "Rails 6 Bookstore Error!!", mail.subject
    assert_equal ["admin@rails6bookstore.com"], mail.to
    assert_equal ["errors@rails6bookstore.com"], mail.from
    assert_match "There has been an error in the application.", mail.body.encoded
    assert_match "this is a problem", mail.body.encoded
  end

end
