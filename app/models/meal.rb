class Meal < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true
  has_many :item_meals, dependent: :destroy
	validates :time, format: {
		with: %r{(2[0-3]|1[0-9]|0[0-9]):([0-5][0-9])},
		message: "must be HH:MM."
	}
end
