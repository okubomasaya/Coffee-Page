Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get "home/about" => "homes#about"
  
  resources :articles, only: [:index, :show, :new, :edit, :create, :destroy, :update] do
    resource :favorites, only: [:create, :destroy]
  end
  
  resources :users, only: [:index, :show, :edit, :update] do 
    resource :relationships, only: [:create, :destroy]
    get 'followed' => 'relationships#followed', as: 'followed'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  
  
  get '/article/hashtag/:name', to: "articles#hashtag"
  
end
