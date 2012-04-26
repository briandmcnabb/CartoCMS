Rails.application.routes.draw do
  Mercury::Engine.routes

  # Devise
  devise_for :admins

  # Admin Interface
  namespace :admin do
    resources :admins
    resources :pages
    resources :assets, only: [:index, :new, :create, :destroy]
  end

  # Pages
  match ':path', to: 'pages#show'
end



Rails.application.routes.draw do
  scope '/mercury' do
    match ':type/:resource' => "mercury#resource"
    match 'snippets/:name/options' => "mercury#snippet_options"
    match 'snippets/:name/preview' => "mercury#snippet_preview"
  end
end