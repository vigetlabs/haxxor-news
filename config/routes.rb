Rails.application.routes.draw do
  root "articles#index"
  resources :articles
  resources :users
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/users/:id/edit_email", to: "users#edit_email", as: "edit_user_email"
  patch "/users/:id/update_email", to: "users#update_email", as: "update_email_user"
  
end
