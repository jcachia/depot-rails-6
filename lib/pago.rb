require 'ostruct'

# a fake, slow payment processor
class Pago
  def self.make_payment(order_id:, payment_method:, payment_details:)
    case payment_method
    when :check
      Rails.logger.info "Processing check: " +
        payment_details.fetch(:routing).to_s + "/" +
        payment_details.fetch(:account).to_s
    when :credit_card
      Rails.logger.info "Processing credit card: " +
        payment_details.fetch(:cc_num).to_s + "/" +
        payment_details.fetch(:expiration_month).to_s + "/" +
        payment_details.fetch(:expiration_year).to_s
    when :po
      Rails.logger.info "Processing purchase order: " +
        payment_details.fetch(:po_num).to_s
    else
      raise "Unknown payment method #{payment_method}"
    end

    sleep 3 unless Rails.env.test? # Don't slow down the tests.

    # make a random failure
    n = rand(10)
    Rails.logger.info("n = #{n}.  If n is 10, payment fails...")
    if n % 10 == 0
      Rails.logger.error("Error in processing payment!  Payment for #{order_id} with payment type #{payment_method} failed!  Admin notified!")
      OpenStruct.new(succeeded?: false)
    else
      Rails.logger.info "Done Processing Payment"
      OpenStruct.new(succeeded?: true) # value = Pago.make_payment(params).  value.succeeded? == true
    end
  end
end