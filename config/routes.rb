ActionController::Routing::Routes.draw do |map|
  map.resources :disenos
  map.resources :colores, :hilos
  map.resources :letters, :only => :show
  map.resources :javascripts, :collection => { :add_hilos => [:post, :put], 
                                               :colores => :post, 
                                               :email_image => :post,
                                               :dynamic_colores => :get, 
                                               :add_colors => [:post, :put],
                                               :timeline => :post }
  Translate::Routes.translation_ui(map)

  map.root :controller => "disenos"
end
