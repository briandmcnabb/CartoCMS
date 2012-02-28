Rails.application.routes.draw do
  match ':page_name' => 'pages#show'
end
