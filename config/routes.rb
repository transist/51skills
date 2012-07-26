Tedx::Application.routes.draw do

  mount PayFu::Engine => '/pay_fu', as: 'pay_fu'

  resources :guides

  get "profiles/edit"
  get "profiles/update"

  resources :email_templates

  get "course_sessions/index"

  post '/search' => 'courses#search'
  get '/search/:q' => 'courses#results'
  resources :courses do
    member { get :submit }
    post :watch
    post :enroll
    post :activate
    post :schedule
    post :postpone
    post :cancel
    post :complete
    resources :course_sessions
    resources :comments, :only => ['create', 'destroy']
  end

  resources :enrollments, only: [:index] do
    member do
      get :confirm
      put :pay
      get :paid
      delete :cancel
    end
  end

  resources :categories do
    collection do
      get :manage
      post :rebuild
    end
    get 'sub_categories'
  end

  Mercury::Engine.routes


  get 'pages' => "pages#index"
  resources :pages do
    member { post :mercury_update }
    member { post :toggle_display }
    resources :presentations do
      resources :slides
    end
    collection do
      get :manage
      post :rebuild
    end
  end
  resources :slides


  # match '/tedxshanghai-2012' => 'home#stage', :slug => 'tedxshanghai-2012'
  root :to => 'courses#index'
  match '/landing' => 'home#landing'
  post '/subscribe' => 'home#subscribe'
  get '/subscribe_confirm' => 'home#subscribe_confirm'

  devise_for :people, :controllers => { :registrations => "registrations" }

  resources :people, :only => [ :show, :edit, :update ] do
    resources :profiles
    resources :providers, :only => [:new, :create, :destroy]
  end

  match '/change_password' => 'sessions#change_password'
  match '/auth/:provider/callback' => 'sessions#create'
  match '/login/:provider' => 'sessions#new', :as => :login
  match '/logout' => 'sessions#destroy', :as => :logout
  match '/auth/failure' => 'sessions#failure'
  match '/zh' => 'home#zh', :locale => 'zh'
  match '/en' => 'home#en', :locale => 'en'
  match '/admin' => 'admin#index'

  get '/:id' => "pages#show"
  put '/:id' => "pages#update"
  get '/pages/:id' => "pages#show"
end
