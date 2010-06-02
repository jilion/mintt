ActionController::Routing::Routes.draw do |map|
  
  map.devise_for :users, :path_names => { :sign_up => 'apply', :sign_in => 'login', :sign_out => 'logout' }
  map.resource :users, :only => [:index]
  map.user_root '/dashboard', :controller => 'users', :action => 'index'
  
  map.devise_for :teachers, :path_names => { :sign_in => 'login', :sign_out => 'logout' }
  map.teacher_root '/lobby', :controller => 'teachers', :action => 'index'
  
  map.contact '/contact', :controller => 'messages', :action => 'new', :conditions => { :method => :get }
  map.resource :messages, :only => [:new, :create], :as => 'contact'
  
  map.admin '/admin', :controller => 'admin/users', :action => 'index'
  map.namespace :admin do |admin|
    admin.resources :users, :member => { :trash => :put }
    admin.resources :teachers
    admin.resources :messages, :collection => { :trashes => :get }, :member => { :reply => :put, :trash => :put, :untrash => :put }
    admin.resources :mail_templates
  end
  
  map.root :controller => 'pages', :action => 'show', :id => 'home'
  
  map.page ':id', :controller => 'pages', :action => 'show', :requirements => { :id => /home|modules/ }
  
  map.connect "*path", :controller => 'pages', :action => 'show', :id => 'home'
  
end