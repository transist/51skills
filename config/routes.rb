Tedx::Application.routes.draw do
  Mercury::Engine.routes
  get 'pages' => "pages#index"
  resources :pages do
    member { post :mercury_update }
  end

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
