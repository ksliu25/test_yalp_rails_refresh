class PagesController < ApplicationController

	include UsersHelper
	def index
		@user = current_user if session[:user_id]
		# redirect_to @user if @user
	end

end