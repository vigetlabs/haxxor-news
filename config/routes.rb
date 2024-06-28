Rails.application.routes.draw do
  root "articles#index"
  resources :articles do
    resources :comments, only: [:create, :show] do
      member do
        post "upvote"
        post "downvote"
      end
    end
    member do
      post "upvote"
      post "downvote"
    end
  end
  resources :users, only: [:create, :show]
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "password/reset", to: "password_resets#new"
  post "password/reset", to: "password_resets#create"
  get "password/reset/edit", to: "password_resets#edit"
  patch "password/reset/edit", to: "password_resets#update"

  get "/users/:id/comments", to: "users#comments", as: "show_comment"
  get "/users/:id/articles", to: "users#articles", as: "show_article"
  get "/users/:id/edit_email", to: "users#edit_email", as: "edit_email_user"
  patch "/users/:id/update_email", to: "users#update_email", as: "update_email_user"
  get "/users/:id/edit_password", to: "users#edit_password", as: "edit_password_user"
  patch "/users/:id/update_password", to: "users#update_password", as: "update_password_user"
end
