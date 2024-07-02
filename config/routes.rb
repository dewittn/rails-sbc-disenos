Hilos::Application.routes.draw do
  resources :disenos
  resources :colores, :hilos
  resources :letters, :only => :show
  resources :javascripts do
    collection do 
      put 'add_hilos'
      post 'add_hilos'
      post 'colores'
      post 'email_image'
      put 'add_colors'
      post 'add_colors'
      get 'timeline'
    end
  end

  root :to => "disenos#index"
end
