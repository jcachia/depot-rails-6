require 'test_helper'

class ApplicaionControllerTest < ActionDispatch::IntegrationTest
  test 'should present error page if exception' do
    id = Order.last.id + 20
    get order_url(id: id)
    assert_redirected_to store_error_url
  end

end