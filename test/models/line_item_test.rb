require 'test_helper'

class LineItemTest < ActiveSupport::TestCase
  setup do
    @line_item = line_items(:one)
  end

  test "remove_one_item! reduces the line_item quantity by 1 and saves if quantity >1" do
    @line_item.quantity = 4
    @line_item.remove_one_item!
    @line_item.reload
    assert_equal @line_item.quantity, 3
  end

  test "remove_one_item! deletes the item if quantity == 1" do
    @line_item.quantity = 1
    assert_difference('LineItem.count', -1) do
      @line_item.remove_one_item!
    end
  end
end
