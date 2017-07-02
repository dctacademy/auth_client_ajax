class User < ActiveRecord::Base

	has_many :contacts
	attr_accessor :password, :password_confirmation

	def save_or_update
		user = User.find_by(email: self.email, auth_token: self.auth_token)
		if !user.nil?
			user.update_attributes(auth_token: self.auth_token)
		else
			self.save
		end
	end
end
