require 'test_helper'

class MealsTest < ActionDispatch::IntegrationTest

	setup do 
		user1 = User.create!(username:"NickiiiMinaj", password:"password", password_confirmation:"password", email:"nicki@minaj.com")
		user1.register
		user2 = User.create!(username:"Fasfas", password:"password", password_confirmation:"password", email:"fasfas@minaj.com")
		user2.register
		host! "localhost:3000"
	end

test "create a empty meal" do
	@user = User.find_by(username: "NickiiiMinaj")
	meal = {
		meal: {
			name: "Nicki Minaj",
			time: "00:45"
			}
		}
		post '/meals', meal, {"Accept" => "application/json"}
		assert_equal 401, response.status
		post '/meals', meal, {"Accept" => "application/json", "Token" => @user.auth_code}
		assert_equal 201, response.status
		assert_equal 1, @user.meals.count
	end


	test 'update a meal' do
		@user = User.find_by!(username: "NickiiiMinaj")
		meal = {
		meal: {
			name: "Nicki Minaj",
			time: "00:45"
			}
		}
		post '/meals', meal, {"Accept" => "application/json", "Token" => @user.auth_code}
		assert_equal 201, response.status

		meal_update = {
			meal: {
				name: "Nicki Minaj_Hot"
			}
		}
		patch "/meals/#{@user.meals.first.id}", meal_update, {"Accept" => "application/json"}

		assert_equal 401, response.status
		patch "/meals/#{@user.meals.first.id}", meal_update, {"Accept" => "application/json", "Token" => @user.auth_code}
		assert_equal 204, response.status


		assert_equal "Nicki Minaj_Hot", @user.meals.first.name
	end

	test 'delete a meal' do
		@user1 = User.find_by!(username: "NickiiiMinaj")
		@user2 = User.find_by!(username:"Fasfas")


		meal = {
		meal: {
			name: "delete",
			time: "18:23"
			}
		}
		post '/meals', meal, {"Accept" => "application/json", "Token" => @user1.auth_code}
		assert_equal 201, response.status
		uri = response.location.split("/").last(2).join("/")

		delete uri, {}, {"Accept" => "application/json", "Token" => @user2.auth_code}
		assert_equal 403, response.status

		delete uri, {}, {"Accept" => "application/json", "Token" => @user1.auth_code}
		assert_equal 204, response.status
	end

end