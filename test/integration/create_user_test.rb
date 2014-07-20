require 'test_helper'

class CreateUserTest < ActionDispatch::IntegrationTest

	test "create user" do
		user = {
			user: {
				username: "alb",
				password: "alb",
				password_confirmation: "alb",
				email: "alb@uniovi.es"
			}
		}
		post "/users", user, {"Accept" => "application/json"}
		assert_equal response.status, 201
	end

	test "create two times the same user" do 
		user = {
			user: {
				username: "alb",
				password: "alb",
				password_confirmation: "alb",
				email: "alb@uniovi.es"
			}
		}
		post "/users", user, {"Accept" => "application/json"}
		assert_equal response.status, 201
		post "/users", user, {"Accept" => "application/json"}
		assert_equal response.status, 422
	end



end