class RemoveColumnUserIdFromMeals < ActiveRecord::Migration
  def change
  	remove_column :meals, :user_id
  end
end
