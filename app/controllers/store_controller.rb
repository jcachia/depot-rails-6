class StoreController < ApplicationController
  include VisitCount
  include CurrentCart

  before_action :set_cart
  skip_before_action :authorize

  def index
    @counter = index_counter
    @products = Product.order(:title)
  end
end
