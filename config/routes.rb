Rails.application.routes.draw do

  # Homepage
  root "static_pages#home"

  # Blog
  resources :posts

  # Users & Clearance
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "clearance/users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end
  get "/sign-in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign-out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign-up" => "clearance/users#new", as: "sign_up"

end
