class LineItem < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :product
  belongs_to :cart, optional: true

  def total_price
    product.price * quantity
  end

  def remove_one_item!
    self.quantity -= 1
    quantity == 0 ? self.delete : save
  end

end
