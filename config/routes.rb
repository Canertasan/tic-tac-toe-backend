Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:show, :index, :create]

  get '/find_user_by_name' => 'users#find_user_by_name'
end
