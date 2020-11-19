require 'test_helper'

class AdminMailerTest < ActionMailer::TestCase
  test "notify_error" do
    mail = AdminMailer.notify_error
    assert_equal "Notify error", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
