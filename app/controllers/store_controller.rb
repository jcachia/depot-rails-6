class StoreController < ApplicationController
  include VisitCount

  def index
    @counter = index_counter
    @products = Product.order(:title)
  end
end
