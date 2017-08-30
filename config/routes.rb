Rails.application.routes.draw do

  resources :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]
  resources :subs
  resources :posts do
    resources :comments, only: [:new]
    member do
      post 'downvote'
      post 'upvote'
    end
  end
  resources :comments, only: [:show, :create] do
    member do
      post 'downvote'
      post 'upvote'
    end
  end
  resources :votes, only: [:destroy]
end
