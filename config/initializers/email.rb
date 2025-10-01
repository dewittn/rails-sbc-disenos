require 'tls_smtp'

ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
  # :enable_starttls_auto => true,
  :address => 'smtp.gmail.com',
  :port => 587,
  :domain => 'cotosolutions.com',
  :authentication => :plain,
  :user_name => 'exception.notifier@cotosolutions.com',
  :password => 'ApP3rRor5'
}

Rails.application.config.middleware.use ExceptionNotification::Rack,
  email: {
    email_prefix: "[ERROR] #{APP_CONFIG['app_title']}: ",
    sender_address: %("Exception Notifier" <exception.notifier@cotosolutions.com>),
    exception_recipients: %w(dewittn@cotosolutions.com)
  }