module VerifyCart

    private

  def verify_cart(cart)
    cart.id == session[:cart_id]
  end

end