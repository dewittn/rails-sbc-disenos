class DisenoSweeper < ActionController::Caching::Sweeper
  observe Diseno
  
  def after_save(diseno)
    expire_cache(diseno)
  end
  
  def after_destroy(diseno)
    expire_cache(diseno)
  end
  
  def expire_cache(diseno)
    return unless @controller
    expire_page :controller => :disenos, :action => :show, :id => diseno
  end
end