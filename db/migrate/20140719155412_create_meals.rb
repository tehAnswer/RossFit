class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.string :time
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
