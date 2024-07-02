class UserMailer < ActionMailer::Base
  default :from => "from@example.com"
  
  def email_design(design,message)
    # @@smtp_settings = {
    #   :address => 'smtp.gmail.com',
    #   :domain => 'sschpa.com',
    #   :port => 587,
    #   :authentication => :plain,
    #   :user_name            => 'disenos@sschpa.com',
    #   :password             => 'S$chadm1n'
    # }
    attachments["#{design.nombre_de_orden}.jpg"] = design.image.path
    mail(:to => message[:to], :subject => message[:subject])
  end
end
