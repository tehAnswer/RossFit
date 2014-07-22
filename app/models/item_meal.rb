class ItemMeal < ActiveRecord::Base
  belongs_to :item
  belongs_to :meal
  has_one :user, through: :meal

  validates :item_id, uniqueness: {scope: :meal_id}


end
