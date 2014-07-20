class User < ActiveRecord::Base
	has_secure_password
	validates :username, presence: true
	validates :username, uniqueness: true


	def register
		self.auth_code = TokenGenerator.create
		save
	end

end