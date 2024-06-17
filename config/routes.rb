Rails.application.routes.draw do
  root "articles#index"
  resources :articles do
    resources :comments, only: [:create, :index]
  end
  resources :users
  resources :articles
  resources :users, only: [:create, :show]
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/users/:id/edit_email", to: "users#edit_email", as: "edit_email_user"
  patch "/users/:id/update_email", to: "users#update_email", as: "update_email_user"
  get "/users/:id/edit_password", to: "users#edit_password", as: "edit_password_user"
  patch "/users/:id/update_password", to: "users#update_password", as: "update_password_user"
end
