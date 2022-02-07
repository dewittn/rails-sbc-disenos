module DisenosHelper
  def diseno_nombre
    @diseno.nombre_de_orden.blank? ? "No Tenia Nombre" : h(@diseno.nombre_de_orden)
  end
  
  def image_url(diseno)
    @diseno.image.url(:medium) ? @diseno.image.url(:medium) : @diseno.image.url
  end
end
