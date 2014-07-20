class Item < ActiveRecord::Base
	ITEM_TYPES = ['Fruit', 'Meat', 'Fish', 'Vegetables', 'Other']

	validates :name, :carbohydrates, :fat, :calories, :protein, :item_type, presence: true
	validates :calories, :carbohydrates, :fat, :protein, numericality: {greater_than_or_equal_to: 0.01}
	validates :name, uniqueness: true
	validates :item_type, inclusion: ITEM_TYPES

	has_many :item_meals
	has_many :meals, through: :item_meals

	before_destroy :ensure_not_referenced


	def ensure_not_referenced
		if item_meals.empty?
			return true
		else
			errors.add(:base, 'The item is referenced for one or more meals.')
			return false;
		end
	end
	
end
