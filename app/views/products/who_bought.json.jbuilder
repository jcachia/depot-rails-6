json.title "Who bought #{@product.title}"

json.updated @latest_order.try(:updated_at)

@product.orders.each do |order|
  json.title "Order #{order.id}"
  json.summary do
    json.shipped_to "#{order.address}"
    json.line_items order.line_items.each do |item|
      json.product item.product.title
      json.quantity item.quantity
      json.total_price number_to_currency item.total_price
    end
    json.total number_to_currency order.line_items.map(&:total_price).sum
    json.paid_by "Paid by #{order.pay_type}"
  end
  json.author do
    json.name order.name
    json.email order.email
  end
end




