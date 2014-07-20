class User < ActiveRecord::Base
	has_secure_password
	has_many :meals
	validates :username, :email, presence: true
	validates :username, :email, uniqueness: true


	def register
		self.auth_code = TokenGenerator.create
		save
	end

end