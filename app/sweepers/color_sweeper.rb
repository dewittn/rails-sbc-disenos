class ColorSweeper < ActionController::Caching::Sweeper
  observe Color
  
  def after_save(color)
    expire_cache(color)
  end
  
  def after_destroy(color)
    expire_cache(color)
  end
  
  def expire_cache(color)
    return unless @controller
    expire_page @controller.colores_path
    expire_page @controller.new_diseno_path
  end
end