# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  include ExceptionNotifiable
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  # protect_from_forgery # :secret => '7a36b02ff1b42d06eeba661106d5fb66'
  
  before_filter :set_default_language
  
  private
  
  def set_default_language
    I18n.locale = request.headers['HTTP_ACCEPT_LANGUAGE'].split(',')[0].split('-')[0]
  end
end
