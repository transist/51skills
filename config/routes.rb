Tedx::Application.routes.draw do
  post '/search' => 'courses#search'
  get '/search/:q' => 'courses#results'
  resources :courses do 
    member { get :submit }
  end

  get "photos" => "photos#index"
  resources :photos

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
  root :to => "home#index"
  resources :people, :only => [ :show, :edit, :update ]
  match '/auth/:provider/callback' => 'sessions#create'
  match '/login' => 'sessions#new', :as => :login
  match '/logout' => 'sessions#destroy', :as => :logout
  match '/auth/failure' => 'sessions#failure'
  match '/zh' => 'home#zh', :locale => 'zh'
  match '/en' => 'home#en', :locale => 'en'
  
  get '/:id' => "pages#show"
  put '/:id' => "pages#update"
  get '/pages/:id' => "pages#show"
  
end
