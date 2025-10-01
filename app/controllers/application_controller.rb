class ApplicationController < ActionController::Base
  protect_from_forgery

  before_action :set_default_language
  
  private
  
  def set_default_language
    I18n.locale = 'es'#request.headers['HTTP_ACCEPT_LANGUAGE'].split(',')[0].split('-')[0] rescue 'es'
  end
end
