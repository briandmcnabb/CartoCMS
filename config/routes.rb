Rails.application.routes.draw do
  # Mercury
  scope '/mercury' do
    match ':type/:resource' => "mercury#resource"
    match 'snippets/:name/options' => "mercury#snippet_options"
    match 'snippets/:name/preview' => "mercury#snippet_preview"
  end

  # Devise
  devise_for :admins

  # Admin Interface
  #constraints subdomain: "cms" do
  #  scope module: "cms", as: "cms"  do
  #    resources :admins
  #    resources :pages
  #    resources :assets, only: [:index, :new, :create, :destroy]
  #  end
  #end

  namespace :cms do
    resources :admins
    resources :pages
    resources :page_templates do
      collection { post :position }
    end
    resources :assets, only: [:index, :new, :create, :destroy]
  end

  # Pages
  match ':path', to: 'pages#show'
end