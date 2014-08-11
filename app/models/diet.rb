class Diet < ActiveRecord::Base
	DIET_TYPES = ['Weight Loss', 'Vegetarian', 'Musculation', 'Other']
	has_many :meals
	belongs_to :user

	validates :name, :diet_type, presence: true
	validates :diet_type, inclusion: DIET_TYPES


	def ordered_meals
		meals.by_time
	end

end
