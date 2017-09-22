Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

 root 'static_pages#home'
 get '/help', to: 'static_pages#help'
 get '/about', to: 'static_pages#about'
 get '/contact', to: 'static_pages#contact'
 get '/signup', to: 'users#new'
 post '/signup', to: 'users#create'
 #sessions: 
 get '/login', to: 'sessions#new'
 post '/login', to: 'sessions#create'
 delete '/logout', to: 'sessions#destroy'


#You might suspect that the URLs for following and followers will look like /users/1/following and /users/1/followers, 
#and that is exactly what the code in Listing 14.15 arranges. Since both pages will be showing data, the proper HTTP verb is a GET request, 
#so we use the get method to arrange for the URLs to respond appropriately. 
#Meanwhile, the member method arranges for the routes to respond to URLs containing the user id. 
#The other possibility, collection, works without the id, so that

 #resources :users

  resources :users do
    member do
      get :following, :followers
    end
  end

 resources :account_activations, only: [:edit]
 resources :password_resets, only: [:new, :create, :edit, :update]
 resources :microposts, only:[:create, :destroy]
resources :relationships,       only: [:create, :destroy]

# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
#  root "application#hello"
end
