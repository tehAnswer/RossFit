class Measure < ActiveRecord::Base
	belongs_to :user
	validates :height, :weight, presence: true
	validates :height, numericality: { greater_than_or_equal_to: 140 }
	validates :weight, numericality: { greater_than_or_equal_to: 35 }
end
