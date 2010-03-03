ActionController::Routing::Routes.draw do |map|

  map.root :controller => 'pages', :action => 'show', :id => 'home'

  map.resource :messages, :only => [:new, :create], :as => 'contact'
  map.contact '/contact', :controller => 'messages', :action => 'new'

  map.resource :users, :only => [:edit, :update]
  map.devise_for :users, :path_names => { :sign_up => 'register' }

  map.namespace :admin do |admin|
    admin.resources :messages
  end

  map.page ':id', :controller => 'pages', :action => 'show', :requirements => { :id => /home|modules/ }

end