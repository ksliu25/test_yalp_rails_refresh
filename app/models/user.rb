require 'bcrypt'

class User < ActiveRecord::Base

	has_many :subscriptions
	has_many :channels, through: :subscriptions

	validates_presence_of :email, :hashed_password
	validate :password_requirements

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
    # only run validations if raw_password is set (not nil)
    # OR if the record hasn't been saved yet (we require a
    # password to create a user)
    if raw_password || new_record?
      # validate that the raw password is at least 6 characters long
      # and contains 1 special character (!@#$%^&*)
      if raw_password.length < 6 || !(raw_password =~ /[!@#$%^&*]/)
        errors.add(:password, "must be at least 6 characters long and contain at least 1 special character (!@#$%^&*).")
      end
    end
  end

end
