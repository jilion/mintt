ActionController::Routing::Routes.draw do |map|
  
  map.root :controller => 'pages', :action => 'show', :id => 'home'
  
  map.resource :users, :only => [:edit, :update]
  map.devise_for :users, :path_names => { :sign_up => 'apply', :sign_in => 'login', :sign_out => 'logout' }
  
  map.resource :messages, :only => [:new, :create], :as => 'contact'
  map.contact '/contact', :controller => 'messages', :action => 'new'
  
  map.user_root '/dashboard', :controller => 'users', :action => 'index'
  
  map.admin '/admin', :controller => 'admin/users', :action => 'index'
  map.namespace :admin do |admin|
    admin.resources :users, :member => { :trash => :put }
    admin.resources :messages, :collection => { :trashes => :get }, :member => { :reply => :put, :trash => :put, :untrash => :put }
    admin.resources :mail_templates
  end
  
  map.page ':id', :controller => 'pages', :action => 'show', :requirements => { :id => /home|modules/ }
  
  map.connect "*path", :controller => 'pages', :action => 'show', :id => 'home'
end