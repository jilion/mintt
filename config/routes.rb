ActionController::Routing::Routes.draw do |map|
  
  map.root :controller => 'pages', :action => 'show', :id => 'home'
  
  map.devise_for :users, :path_names => { :sign_up => 'register' }
  
  map.new_user 'register', :controller => 'users', :action => 'new'
  map.resource :users, :only => [:create, :edit, :update]
  
end