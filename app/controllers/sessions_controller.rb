class SessionsController < ApplicationController

	def new
		@user = User.new
	end

	def create
		@user = User.find_by(email: user_params[:email])
		if @user and User.authenticate(@user.email, user_params[:password])
			session[:user_id] = @user.id
			redirect_to :root
		else
			flash[:error] = "Oops, something went wrong!"
			render "new"
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to :root
	end

	private

	def user_params
		params.require(:user).permit(:email, :password)
	end

end