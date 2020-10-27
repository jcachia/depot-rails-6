class Order < ApplicationRecord
  enum pay_type: {
    "Check"           => 0,
    "Credit Card"     => 1,
    "Purchase Order"  => 2
  }
  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: pay_types.keys

  def self.add_line_items_to_cart(cart)
    cart.line_item.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

end
