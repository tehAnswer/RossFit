RossfitApi::Application.routes.draw do

  resources :users, only: :create
  get '/login' => 'login#login'
end
