class Meal < ActiveRecord::Base
  belongs_to :diet
  validates :name, presence: true
  has_many :item_meals, dependent: :destroy
  has_one :user, through: :diet

	validates :time, format: {
		with: %r{(2[0-3]|1[0-9]|0[0-9]):([0-5][0-9])},
		message: "must be HH:MM."
	}

	scope :by_time, -> { order('time ASC') }
end
