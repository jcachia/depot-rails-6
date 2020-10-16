require 'test_helper'

class CartTest < ActiveSupport::TestCase
  fixtures :carts
  fixtures :products

  test "new product should add new record" do
    @cart = Cart.new
    @product = products(:one)
    @line_item = @cart.add_product(@product)
    @line_item.save
    assert_equal @cart.line_items.count, 1
    assert_equal @cart.line_items.find_by(product_id: @product.id).quantity, 1
  end

  test "additional products should increment quantity" do
    @cart = Cart.new
    @product = products(:one)
    2.times do
      @line_item = @cart.add_product(@product)
      @line_item.save
    end
    assert_equal @cart.line_items.count, 1
    assert_equal @cart.line_items.find_by(product_id: @product.id).quantity, 2
  end

end
