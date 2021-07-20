Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get "home/about" => "homes#about"
  
  resources :articles, only: [:index, :show, :new, :edit, :create, :destroy, :update] do
    resource :favorites, only: [:create, :destroy]
  end
  
  resources :users, only: [:index, :show, :edit, :update] do 
    
    get 'users/following/:user_id', to: 'users#following', as:'users_following'
   get 'users/follower/:user_id', to: 'users#follower', as:'users_follower'
    post 'follow/:id', to: 'relationships#follow', as: 'follow'
    post 'unfollow/:id', to: 'relationships#unfollow', as: 'unfollow'
  end
  
  
  get '/article/hashtag/:name', to: "articles#hashtag"
  
end
