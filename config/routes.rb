Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/v1/auth', controllers: {
    registrations: :facebook_login
  }
  namespace :api do
    namespace :v1 do
      resources :tracks, only: [:index], constraints: { format: "json" }
      resources :artists, only: [:index], constraints: { format: "json" }
    end
  end
end
