module ColoresHelper
  def button_text
    new_path? ? t('color.new.save') : t('color.edit.save')
  end
  
  def action_path
    new_path? ? colores_path : colore_path(@color)
  end
  
  def title_text
    new_path? ? t('color.new.title') : t('color.edit.title')
  end
  
  def new_path?
    params[:action] == "new" || params[:action] == "create"
  end
end
