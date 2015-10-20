require 'bcrypt'

class User < ActiveRecord::Base

	has_many :subscriptions
	has_many :channels, through: :subscriptions

	validate :password_requirements
	validates_presence_of :email, :hashed_password

	def password
		@password ||= BCrypt::Password.new(hashed_password)
	end

	def password=(new_password)
		@raw_password = new_password
		@password = BCrypt::Password.create(new_password)
		self.hashed_password = @password
	end

	def self.authenticate(email, password)
		@user = User.find_by_email(email)
		@user if @user && @user.password == password
	end

	private

	def raw_password
		@raw_password
	end

	def password_requirements
		if raw_password || new_record?
			if raw_password.length < 6 || !(raw_password =~ /[!@#$%^&*]/)
				errors.add(:password, "Password must be at least 6 characters long and contain a special character (!@#$%^&*)!")
			end
		end
end
