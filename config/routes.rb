ActionController::Routing::Routes.draw do |map|
  
  map.root :controller => 'pages', :action => 'show', :id => 'home'
  map.page ':id', :controller => 'pages', :action => 'show', :requirements => { :id => /home|modules/ }
   
  map.devise_for :users, :path_names => { :sign_up => 'register' }
  
  map.resource :users, :only => [:create, :edit, :update]
  
end