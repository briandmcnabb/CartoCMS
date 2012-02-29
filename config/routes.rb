Rails.application.routes.draw do
  devise_for :admins

  match ':page_name' => 'pages#show'
end
