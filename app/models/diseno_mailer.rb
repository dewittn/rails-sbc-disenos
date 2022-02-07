class DisenoMailer < ActionMailer::Base
  
  def email_image(diseno, message)
    @@smtp_settings = {
      :address => 'smtp.gmail.com',
      :domain => 'sschpa.com',
      :port => 587,
      :authentication => :plain,
      :user_name            => 'ssch@sschpa.com',
      :password             => 'S$chadm1n'
    }
    recipients  message[:to]
    from        "ssch@sschpa.com"
    subject     message[:subject]
    body        :diseno => diseno
    attachment  :content_type => "image/jpeg", :body => File.read(diseno.image.path)
  end
end
