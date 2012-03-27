Rails.application.routes.draw do
  devise_for :admins
  namespace :admin do
    resources :admins
    resources :pages do
      resources :assets
    end
    resources :assets
  end
end
