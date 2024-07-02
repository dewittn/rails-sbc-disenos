Hilos::Application.routes.draw do
  resources :javascripts do
    collection do
      get 'path_prefix'
    end
  end
end