class UsersController < ApplicationController

	def index
		@users = User.all
	end
	def new
		@user = User.new
	end

	def create
		@user = User.create(user_params)
		if @user.valid?
			session[:user_id] = @user.id
		else
			render 'new'
		end
	end

	def show
		@user = User.find(params[:id])
		@subscriptions = @user.subscriptions
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		@user.update_attributes!(user_params)
		redirect_to @user
	end

	def destroy
		User.find(params[:id]).destroy
		redirect_to login_url
	end

	private

	def user_params
		params.require(:user).permit(:email, :password)
	end

end