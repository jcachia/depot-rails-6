class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  def total_price
    product.price * quantity
  end

  def remove_one_item!
    self.quantity -= 1
    quantity == 0 ? self.delete : save
  end

end
