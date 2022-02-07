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

ExceptionNotifier.exception_recipients = %w(dewittn@cotosolutions.com)
ExceptionNotifier.sender_address = %("Exception Notifier" <exception.notifier@cotosolutions.com>)
ExceptionNotifier.email_prefix ="[ERROR] Landscaping: "