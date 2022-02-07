module DisenosHelper
  def diseno_nombre
    @diseno.nombre_de_orden.blank? ? "No Tenia Nombre" : h(@diseno.nombre_de_orden)
  end
end
