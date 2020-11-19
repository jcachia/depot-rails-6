class AdminMailer < ApplicationMailer
  default from: 'BookStore Errors <errors@rails6bookstore.com>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.admin_mailer.notify_error.subject
  #
  def notify_error(exception)
    @exception = exception

    mail to: "admin@rails6bookstore.com", subject: "Rails 6 Bookstore Error!!"
  end
end
