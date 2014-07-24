class RemoveUserFromMeal < ActiveRecord::Migration
  def change
  	remove_reference :meals, :user
  end
end
