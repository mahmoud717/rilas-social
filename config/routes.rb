Rails.application.routes.draw do

  root 'posts#index'
  post "/sendfriendrequest/:user_id/:friend_id" , to: "friendships#new", as:"sendfriendrequest"
  post "/confirmfriendrequest/:friendship_id" , to: "friendships#confirm", as:"confirmfriendrequest"
  post "/cancelfriendrequest/:friendship_id" , to: "friendships#cancel", as: "cancelfriendrequest"
  post "/unfriend/:user_id/:friend_id" , to: "friendships#unfriend", as: "unfriend"
  get "/friends" , to: "users#friends" ,as: "friends"
  devise_for :users

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end
  

end
