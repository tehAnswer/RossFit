class LoginController < ApplicationController

	def login
		puts request.headers[:token]
		username = request.params[:login][:username]
		password = request.params[:login][:password]
		@user = User.find_by(username: username)
	
			
		if !@user.nil? && @user.password = password
			render 'users/login', status: 200
		else
			render json: "Bad username/password combination", status: 401
		end
	end

	def user_params
		params.require(:login).permit(:username, :password)
	end

end