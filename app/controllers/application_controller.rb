class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session


  def check_if_user_exists
  	token = request.headers[:token]
    user = User.find_by(auth_code: token)
    if token.nil? || user.nil?
      render json: "Bad credentials", status: 401
    else
      @user_id = user.id
    end
  end

  def check_for_user(item)
  	token = request.headers[:token]
  	if token.nil?
  		render json: "Unathorized", status: 401
  	elsif item.user.auth_code != token
  		render json: "Forbidden", status: 403
  	end 
  end

end
