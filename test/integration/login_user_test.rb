require 'test_helper'

class LoginUserTest < ActionDispatch::IntegrationTest

	setup do 
		user = User.create!(username:"user", password:"password", password_confirmation:"password", email:"example@example.com")
		user.register
	end

	test "valid login retuns the auth code" do
		login = {
			login: {
				username: "user",
				password: "password"
			}
		}
		get "/login", login, {"Accept" => "application/json"}

		assert_equal response.status, 200
		assert_equal response.content_type, Mime::JSON

		json = json(response.body)
		assert_equal json[:token], User.find_by(username:"user").auth_code
	end


end
