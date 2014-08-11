RossfitApi::Application.routes.draw do

  resources :measures

  resources :diets

	resources :item_meals
	resources :meals
	resources :items
	resources :users, only: :create
	get '/login' => 'login#login'
  
end
