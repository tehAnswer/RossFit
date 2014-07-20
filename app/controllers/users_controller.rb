class UsersController < ApplicationController

	def create
		@user = User.new(user_params)
		if @user.register
			render json: @user, status: 201
		else
			render json: @user.errors, status: 422
		end
	end

	def user_params
		params.require(:user).permit(:username, :password, :password_confirmation, :email)
	end
end