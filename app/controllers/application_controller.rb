class ApplicationController < ActionController::Base
  rescue_from Exception, with: :notify_admin

    private

  def notify_admin(exception)
    AdminMailer.notify_error(exception).deliver_now
    redirect_to store_error_url
  end

end
