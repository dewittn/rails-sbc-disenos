ActionController::Routing::Routes.draw do |map|
  map.resources :disenos, :colores, :hilos
  map.resources :letters, :only => :show
  map.resources :javascripts, :collection => { :edit_colores => :post, :colores => :post, :dynamic_colores => :get }
  Translate::Routes.translation_ui(map)

  map.root :controller => "disenos"
end
