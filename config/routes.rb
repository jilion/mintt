Mintt::Application.routes.draw do
  devise_for :users, :path_names => { :sign_in => 'login', :sign_out => 'logout' }, :skip => [:registrations] do
    scope :controller => 'users/registrations', :as => :user_registration do
      get  :new,    :path => '/apply'
      post :create, :path => '/apply', :as => ''
    end
    scope :controller => 'devise/registrations', :as => :user_registration do
      get  :edit,   :path => '/user_account/edit'
      put  :update, :path => '/user_account/credentials'
    end
  end
  
  devise_for :teachers,
  :path_names => { :sign_in => 'login', :sign_out => 'logout' }, :skip => [:invitations, :registrations] do
    scope :controller => 'admin/teachers/invitations', :as => :teacher_invitation do # admin routes
      get  :new,    :path => '/admin/teachers/invitation/new'
      post :create, :path => '/admin/teachers/invitation', :as => ''
    end
    scope :controller => 'devise/invitations', :as => :teacher_invitation do
      get :edit,   :path => '/invitation/accept', :as => 'accept'
      put :update, :path => '/invitation'
    end
    scope :controller => 'devise/registrations', :as => :teacher_registration do
      get  :edit,   :path => '/teacher_account/edit'
      put  :update, :path => '/teacher_account/credentials'
    end
  end
  resources :teachers, :only => [:update]
  
  match '/program' => "programs#index", :as => "program"
  
  match '/contact' => 'messages#new'
  resource :messages, :only => [:new, :create]
  
  # =========
  # = Admin =
  # =========
  match '/admin' => 'admin/users#index', :as => 'admin'
  namespace :admin do
    resources :documents
    resources :mail_templates, :only => [:index, :show, :edit, :update]
    resources :messages, :only => [:index, :show, :update]
    resources :teachers, :only => [:index, :show, :edit, :update, :destroy]
    resources :users, :only => [:index, :show, :edit, :update]
  end
  
  root :to => 'pages#show', :id => 'home'
  
  match ':id' => 'pages#show', :requirements => { :id => /home|modules/ }, :as => 'page'
  
  match "*path" => redirect('pages#show'), :id => 'home'
end