RossfitApi::Application.routes.draw do

  resources :measures, except: :index
  resources :diets

	resources :item_meals, except: :index
	resources :meals, except: :index
	resources :items
	resources :users, only: :create
	get '/login' => 'login#login'
  
end
