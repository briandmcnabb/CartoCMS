Rails.application.routes.draw do
  # Mercury
  scope '/mercury' do
    match ':type/:resource' => "mercury#resource"
    match 'snippets/:name/options' => "mercury#snippet_options"
    match 'snippets/:name/preview' => "mercury#snippet_preview"
  end

  # Devise
  devise_for :users, controllers: { registrations: "cms/registrations" }

  # Admin Interface
  #constraints subdomain: "cms" do
  #  scope module: "cms", as: "cms"  do
  #    resources :users
  #    resources :pages
  #    resources :assets, only: [:index, :new, :create, :destroy]
  #  end
  #end

  namespace :cms do
    resources :assets, only: [:index, :new, :create, :destroy]
    resources :users, except: [:edit, :update]
    resources :pages, except: [:show]
    resources :page_templates, except: [:show] do
      collection { post :position }
    end
    resources :sliders, except: [:show] do
      collection { post :position }
    end
    resources :slides, except: [:index, :show] do
      collection { post :position }
    end
  end

  # Pages
  match ':path', to: 'pages#show'
end