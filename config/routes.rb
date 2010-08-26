Mintt::Application.routes.draw do
  devise_for :users,
  :controllers => { :confirmations => 'users/confirmations', :sessions => 'sessions' },
  :path_names => { :confirmation => 'confirm', :sign_in => 'login', :sign_out => 'logout' },
  :skip => [:registrations] do
    scope :controller => 'users/applications', :as => :user_application do
      get  :new,    :path => '/apply'
      post :create, :path => '/apply', :as => ''
    end
    scope :controller => 'devise/registrations', :as => :user_registration do
      get :edit,   :path => '/user_account/edit'
      put :update, :path => '/user_account', :as => ''
    end
  end
  
  devise_for :teachers,
  :controllers => { :sessions => 'sessions' },
  :path_names => { :sign_in => 'login', :sign_out => 'logout' },
  :skip => [:invitations, :registrations] do
    scope :controller => 'admin/teachers/invitations', :as => :teacher_invitation do # admin routes
      get  :new,    :path => '/admin/teachers/invitation/new'
      post :create, :path => '/admin/teachers/invitation', :as => ''
    end
    scope :controller => 'devise/invitations', :as => :teacher_invitation do
      get :edit,   :path => '/invitation/accept', :as => 'accept'
      put :update, :path => '/invitation'
    end
    scope :controller => 'devise/registrations', :as => :teacher_registration do
      get :edit,   :path => '/teacher_account/edit'
      put :update, :path => '/teacher_account', :as => ''
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