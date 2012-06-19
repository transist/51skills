Tedx::Application.routes.draw do
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
    resources :course_sessions
    resources :comments, :only => ['create', 'destroy']
  end
  resources :categories do
    collection do
      get :manage
      post :rebuild
    end
    get 'sub_categories'
  end

  #get "photos" => "photos#index"
  #resources :photos

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
  root :to => 'home#index'
  match '/landing' => 'home#landing'
  post '/subscribe' => 'home#subscribe'
  get '/subscribe_confirm' => 'home#subscribe_confirm'
  
  resources :people, :only => [ :show, :edit, :update ] do
    resources :profiles
  end
  
  match '/auth/:provider/callback' => 'sessions#create'
  match '/login/:provider' => 'sessions#new', :as => :login
  match '/logout' => 'sessions#destroy', :as => :logout
  match '/auth/failure' => 'sessions#failure'
  match '/zh' => 'home#zh', :locale => 'zh'
  match '/en' => 'home#en', :locale => 'en'
  
  get '/:id' => "pages#show"
  put '/:id' => "pages#update"
  get '/pages/:id' => "pages#show"
  
end
