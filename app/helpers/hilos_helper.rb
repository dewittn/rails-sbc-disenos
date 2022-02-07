module HilosHelper
  def title_text
    hilos_new ? t('thread.new.title') : t('thread.new.edit_title')
  end
  def form_url
    hilos_new ? hilos_path : hilo_path(@marca)
  end
  
  def button_text
    hilos_new ? t('thread.new.create') : t('thread.new.save')
  end
  
  def hilos_new
    params[:action] == "new" || params[:action] == "create"
  end
end
