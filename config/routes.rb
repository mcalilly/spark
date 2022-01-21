Rails.application.routes.draw do

  root to: "static_pages#home"

  # Devise
  devise_for :users
  devise_scope :user do
    get "/sign-in", to: "devise/sessions#new", as: "sign_in"
    get "/join", to: "devise/registrations#new", as: "sign_up"
    get "/logout", to: "devise/sessions#destroy", as: "log_out"
  end

  # Static Pages
  get "/about", to: "static_pages#about", as: "about"
  get "/contact-us", to: "static_pages#contact_us", as: "contact"

end
