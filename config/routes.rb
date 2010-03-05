ActionController::Routing::Routes.draw do |map|
  
  map.root :controller => 'pages', :action => 'show', :id => 'home'
  
  map.resource :users, :only => [:edit, :update]
  map.devise_for :users, :path_names => { :sign_up => 'apply' }
  
  map.resource :messages, :only => [:new, :create], :as => 'contact'
  map.contact '/contact', :controller => 'messages', :action => 'new'
  
  map.redirect '/admin', :controller => 'admin/users', :action => 'index'
  map.namespace :admin do |admin|
    admin.resources :users
    admin.resources :messages, :collection => { :trash => :get }
    admin.resources :mail_templates
  end
  
  map.page ':id', :controller => 'pages', :action => 'show', :requirements => { :id => /home|modules/ }
  
end