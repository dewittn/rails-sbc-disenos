ActionController::Routing::Routes.draw do |map|
  map.resources :javascripts, :collection => { :path_prefix => :get }, :only => :path_prefix
end
