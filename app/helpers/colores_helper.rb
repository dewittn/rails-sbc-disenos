module ColoresHelper
  def button_text
    new_path? ? "Crear =>" : "guadar"
  end
  
  def action_path
    new_path? ? colores_path : colore_path(@color)
  end
  
  def title_text
    new_path? ? "Nuevo color" : "Editar color"
  end
  
  def new_path?
    params[:action] == "new" || params[:action] == "create"
  end
end
