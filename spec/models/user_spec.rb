require 'rails_helper'

describe User do
	let(:valid_attributes) { {email: "ksliu25@gmail.com", password: "password!"} }
	context "validations" do
		let(:user){ User.new(valid_attributes)}
		it "requires an email" do
			expect(user).to validate_presence_of(:email)
		end
	end

end