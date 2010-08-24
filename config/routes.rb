Mintt::Application.routes.draw do
  devise_for :users, :path_names => { :sign_up => 'apply', :sign_in => 'login', :sign_out => 'logout' }
  
  match '/program' => "programs#index", :as => "user_root"
  
  devise_for :teachers,
  :path_names => { :sign_in => 'login', :sign_out => 'logout' }, :skip => [:invitations] do
    scope :controller => 'admin/teachers/invitations', :as => :teacher_invitation do # admin routes
      get  :new,    :path => '/admin/teachers/invitation/new'
      post :create, :path => '/admin/teachers/invitation', :as => ''
    end
    scope :controller => 'devise/invitations', :as => :teacher_invitation do
      get :edit,   :path => '/invitation/accept', :as => 'accept'
      put :update, :path => '/invitation', :as => ''
    end
  end
  match '/program' => "programs#index", :as => "teacher_root"
  
  resources :teachers, :only => :update
  
  match '/contact' => 'messages#new'
  resource :messages, :only => [:new, :create], :as => 'contact'
  
  # =========
  # = Admin =
  # =========
  match '/admin' => 'admin/users#index', :as => 'admin'
  namespace :admin do
    resources :users do
      member do
        put :trash
      end
    end
    
    resources :teachers
    # scope :controller => 'teachers/invitations', :as => :teacher_invitation do
    #   get  :new,    :path => 'teachers/invitation/new'
    #   post :create, :path => 'teachers/invitation', :as => ''
    # end
    
    resources :documents
    resources :messages do
      collection do
        get :trashes
      end
      member do
        put :reply
        put :trash
        put :untrash
      end
    end
    resources :mail_templates, :except => [:destroy]
  end
  
  root :to => 'pages#show', :id => 'home'
  
  match ':id' => 'pages#show', :requirements => { :id => /home|modules/ }, :as => 'page'
  
  match "*path" => redirect('pages#show'), :id => 'home'
end