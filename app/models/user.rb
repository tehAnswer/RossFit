class User < ActiveRecord::Base
	has_secure_password
	has_many :diets
	has_many :measures
	has_many :meals, through: :diets
	validates :username, :email, presence: true
	validates :username, :email, uniqueness: true
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i


	def register
		self.auth_code = TokenGenerator.create
		save
	end

end