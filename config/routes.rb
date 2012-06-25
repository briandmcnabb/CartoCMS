Rails.application.routes.draw do
  # Mercury
  scope '/mercury' do
    match ':type/:resource' => "mercury#resource"
    match 'snippets/:name/options' => "mercury#snippet_options"
    match 'snippets/:name/preview' => "mercury#snippet_preview"
  end

  # Devise
  devise_for :users, controllers: { registrations: "cms/registrations" }

  # Omniauth
  match '/auth/:provider/callback' => 'cms/omniauth#callback'
  match '/auth/failure' => 'cms/omniauth#failure'

  namespace :cms do
    resources :assets, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :pages, except: [:show]
    resource  :setting, path: "/settings", only: [] do
      resources :connections, only: [:index, :destroy]
    end
    resources :sliders, except: [:show] do
      collection { post :position }
    end
    resources :slides, except: [:index, :show, :new] do
      collection { post :position }
      resources :assets, only: [:new, :create]
    end
    resources :templates, except: [:show] do
      collection { post :position }
    end
    resources :users, except: [:new, :edit]
  end

  # Pages
  match ':path', to: 'pages#show'
end