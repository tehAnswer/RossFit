class LoginController < ApplicationController

	def login
		username = request.params[:login][:username]
		password = request.params[:login][:password]
		user = User.find_by(username: username) #, password_digest: password)
		if !user.nil? && user.password = password
			render json: { token: user.auth_code }, status: :ok
		else
			render json: "Bad username/password combination", status: 401
		end
	end

	def user_params
		params.require(:login).permit(:username, :password)
	end

end