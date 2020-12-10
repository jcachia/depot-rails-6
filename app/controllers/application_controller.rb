class ApplicationController < ActionController::Base
  before_action :authorize
  rescue_from Exception, with: :notify_admin

    protected

  def authorize
    unless User.find_by(id: session[:user_id])
      redirect_to login_url, notice: "Please log in"
    end
  end

    private

  def notify_admin(exception)
    AdminMailer.notify_error(exception).deliver_now
    redirect_to store_error_url
  end

end
