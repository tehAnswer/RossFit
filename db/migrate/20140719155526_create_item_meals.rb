class CreateItemMeals < ActiveRecord::Migration
  def change
    create_table :item_meals do |t|
      t.decimal :quantity
      t.references :item, index: true
      t.belongs_to :meal, index: true

      t.timestamps
    end
  end
end
