require 'test_helper'

class StoreControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get store_index_url
    assert_response :success
    # Selectors that start with:
    #   - # match on id attribute
    #   - . match on class attributes
    #   - no prefix match on element names 
    # If the second parameter is a number, we look for a count.  If it is a string, we look to match. 
    assert_select 'nav.side_nav a', minimum: 4 # an element contained in a nave that has the class 'side_nav'
    assert_select 'main ul.catalog li', 3 # an li element inside a ul element with a catalog class, which is inside a main element.
    assert_select 'h2', 'A Ruby Book'
    assert_select '.price', /\$[,\d]+\.\d\d/
  end

end
