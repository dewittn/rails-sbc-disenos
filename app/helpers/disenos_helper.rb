module DisenosHelper
  def diseno_nombre
    @diseno.nombre_de_orden.blank? ? t('deisgn.missing_name') : h(@diseno.nombre_de_orden)
  end
  
  def image_url(diseno)
    @diseno.image.url(:medium) ? @diseno.image.url(:medium) : @diseno.image.url
  end
  
  def create_save_text
    params[:action] == "new" || params[:action] == "create" ? t('design.new.save') : t('design.edit.save')
  end
end
