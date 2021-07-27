Rails.application.routes.draw do

  get 'searches/search'
  devise_for :users
  root to: 'homes#top'
  get "home/about" => "homes#about"

  resources :articles, only: [:index, :show, :new, :edit, :create, :destroy, :update] do
    resource :favorites, only: [:create, :destroy]
  end

  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
  	get 'followings' => 'relationships#followings', as: 'followings'
  	get 'followers' => 'relationships#followers', as: 'followers'
  end

  #search
  get '/search', to: 'searches#search'
  #hashtag
  get '/article/hashtag/:name', to: "articles#hashtag"

end
