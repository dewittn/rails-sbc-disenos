class DisenoSweeper < ActionController::Caching::Sweeper
  observe Diseno
  
  def after_save(diseno)
    expire_cache(diseno)
  end
  
  def after_destroy(diseno)
    expire_cache(diseno)
  end
  
  def expire_cache(diseno)
    expire_page edit_diseno_path(diseno)
  end
end