Mintt::Application.routes.draw do
  devise_for :users,
  :controllers => { :confirmations => 'users/confirmations' },
  :path_names => { :confirmation => 'confirm', :sign_in => 'login', :sign_out => 'logout' },
  :skip => [:registrations]
  devise_scope :user do
    resource :user_registration, :only => [], :controller => 'users/registrations', :path => '' do
      get  :new,    :path => '/apply', :as => 'new'
      post :create, :path => '/apply'
    end

    resource :user, :only => [], :controller => 'users/registrations', :path => '' do
      get :edit,    :path => '/user_account/edit', :as => 'edit'
      put :update,  :path => '/user_account'
    end

  end

  devise_for :teachers,
  :path_names => { :sign_in => 'login', :sign_out => 'logout' },
  :skip => [:invitations, :registrations]
  devise_scope :teacher do
    resource :admin_teacher_invitation, :only => [], :controller => 'admin/teachers/invitations', :path => "" do
      get  :new,    :path => '/admin/teachers/invitation/new', :as => 'new'
      post :create, :path => '/admin/teachers/invitation'
    end

    resource :teacher_invitation, :only => [], :controller => 'devise/invitations', :path => "" do
      get :edit,   :path => '/invitation/accept', :as => 'accept'
      put :update, :path => '/invitation'
    end

    resource :teacher, :only => [], :controller => 'teachers/registrations', :path => '' do
      get :edit,   :path => '/teacher_account/edit', :as => 'edit'
      put :update, :path => '/teacher_account'
    end
  end
  resource :teachers, :only => :update
  resources :documents, :only => :show

  match '/schedule' => "programs#index", :as => 'program'

  match '/contact' => 'messages#new',    :via => :get, :as => 'contact'
  match '/contact' => 'messages#create', :via => :post, :as => 'contact'

  # =========
  # = Admin =
  # =========
  match '/admin' => redirect('/admin/users'), :as => 'admin'
  namespace :admin do
    resources :users, :only => [:index, :show, :edit, :update]
    resources :teachers, :only => [:index, :show, :edit, :update, :destroy]
    resources :documents do
      collection do
        post :modules
      end
    end
    resources :teaching_modules, :path => :modules
    resources :messages, :only => [:show, :update] do
      collection do
        get 'inbox' => 'messages#index', :as => 'inbox'
        get 'trash' => 'messages#index', :trashed => true, :as => 'trash'
      end
    end
    resources :mail_templates, :only => [:index, :show, :edit, :update]
  end

  root :to => 'pages#show', :id => 'home'

  get ':id' => 'pages#show', :id => /home|modules/, :as => 'page'

  # match "*path" => redirect('pages#show'), :id => 'home'
end
