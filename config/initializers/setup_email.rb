ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "cotosolutions.com",
  :user_name            => "exception.notifier@cotosolutions.com",
  :password             => "ApP3rRor5",
  :authentication       => "plain",
  :enable_starttls_auto => true
}