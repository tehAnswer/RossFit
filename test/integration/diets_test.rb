require 'test_helper'

class DietsTest < ActionDispatch::IntegrationTest

  setup do 
  	user1 = User.create!(username:"NickiiiMinaj", password:"password", password_confirmation:"password", email:"nicki@minaj.com")
		user1.register
		user2 = User.create!(username:"Fasfas", password:"password", password_confirmation:"password", email:"fasfas@minaj.com")
		user2.register

	end

	test 'create a diet' do

		@user = User.find_by(username:"NickiiiMinaj")

		
		diet = {
			diet: {
				name: "A",
				diet_type: "Other",
				user_id: @user.id
			}
		}

		post '/diets', diet, {"Accept" => "application/json"}
		assert_equal 401, response.status

		post '/diets', diet, {"Accept" => "application/json", "Token" => @user.auth_code }
		assert_equal 201, response.status
	end

	test 'update a diet' do
		@user = User.first
		diet = {
			diet: {
				name: "A",
				diet_type: "Other",
				user_id: @user.id
			}
		}

		post '/diets', diet, {"Accept" => "application/json", "Token" => @user.auth_code }
		assert_equal 201, response.status

		wrong_diet = {
			diet: {
				name: "Anthonny Bennet",
				user_id: 20
			}
		}

		correct_diet = {
			diet: {
				name: "Anthonny Bennet"
			}
		}

		uri = response.location.split("/").last(2).join("/")

		patch uri, wrong_diet, {"Accept" => "application/json", "Token" => @user.auth_code }
		# Saved update but ignored wrong user_id
		assert_equal 204, response.status
		

		patch uri, correct_diet, {"Accept" => "application/json", "Token" => @user.auth_code }
		assert_equal 204, response.status

	end


	test 'delete a diet' do
		@user = User.first
		diet = {
			diet: {
				name: "A",
				diet_type: "Other",
				user_id: @user.id
			}
		}

		post '/diets', diet, {"Accept" => "application/json", "Token" => @user.auth_code }
		assert_equal 201, response.status

		uri = response.location.split("/").last(2).join("/")

		delete uri, diet, {"Accept" => "application/json"}
		assert_equal 401, response.status


		delete uri, diet, {"Accept" => "application/json", "Token" => @user.auth_code }
		assert_equal 204, response.status

	end


end