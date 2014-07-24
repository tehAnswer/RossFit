class AddDietToMeal < ActiveRecord::Migration
  def change
    add_reference :meals, :diet, index: true
  end
end
