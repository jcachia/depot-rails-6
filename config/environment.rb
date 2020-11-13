# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

Rails.application.configure do
  config.action_mailer.delivery_method = :smtp # or :sendmail or :test.  sendmail will send to the local system's sendmail program, assumed to be in /usr/sbin.

  # Some Gmail defaults:
  config.action_mailer.smtp_settings = {
    address:        "smtp.gmail.com",
    port:           587,
    domain:         "rails6bookstore.com",
    authenticaion:  "public",
    user_name:      "jason",
    password:       "secret",
    enable_starttls_auto: true
  }
end