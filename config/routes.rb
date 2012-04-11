Rails.application.routes.draw do
  # Devise
  devise_for :admins

  # Admin Interface
  namespace :admin do
    resources :admins
    resources :pages do
      resources :assets
    end
    resources :assets
  end

  # Pages
  match ':path', to: 'pages#show'
end

