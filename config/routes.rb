Mintt::Application.routes.draw do
  devise_for :users,
  :controllers => { :confirmations => 'users/confirmations', :sessions => 'sessions' },
  :path_names => { :confirmation => 'confirm', :sign_in => 'login', :sign_out => 'logout' },
  :skip => [:registrations] do
    resource :user_application, :only => [], :controller => 'users/applications', :path => '' do
      get  :new,    :path => '/apply', :as => 'new'
      post :create, :path => '/apply'
    end
    
    resource :user_registration, :only => [], :controller => 'devise/registrations', :path => '' do
      get :edit,    :path => '/user_account/edit', :as => 'edit'
      put :update,  :path => '/user_account'
    end
    
  end
  
  devise_for :teachers,
  :controllers => { :sessions => 'sessions' },
  :path_names => { :sign_in => 'login', :sign_out => 'logout' },
  :skip => [:invitations, :registrations] do
    resource :teacher_invitation, :only => [], :controller => 'admin/teachers/invitations', :path => "" do
      get  :new,    :path => '/admin/teachers/invitation/new', :as => 'new'
      post :create, :path => '/admin/teachers/invitation'
    end
    
    resource :teacher_invitation, :only => [], :controller => 'devise/invitations', :path => "" do
      get :edit,   :path => '/invitation/accept', :as => 'accept'
      put :update, :path => '/invitation'
    end
    
    resource :teacher_registration, :only => [], :controller => 'devise/registrations', :path => '' do
      get :edit,   :path => '/teacher_account/edit', :as => 'edit'
      put :update, :path => '/teacher_account'
    end
  end
  resource :teachers, :only => [:update]
  
  match '/program' => "programs#index", :as => 'program'
  
  match '/contact' => 'messages#new',    :via => :get, :as => 'contact'
  match '/contact' => 'messages#create', :via => :post, :as => 'contact'
  
  # =========
  # = Admin =
  # =========
  match '/admin' => redirect('/admin/users'), :as => 'admin'
  namespace :admin do
    resources :documents
    resources :mail_templates, :only => [:index, :show, :edit, :update]
    resources :messages, :only => [:index, :show, :update]
    resources :teachers, :only => [:index, :show, :edit, :update, :destroy]
    resources :users, :only => [:index, :show, :edit, :update]
  end
  
  root :to => 'pages#show', :id => 'home'
  
  match ':id' => 'pages#show', :id => /home|modules/, :as => 'page'
  
  match "*path" => redirect('pages#show'), :id => 'home'
end