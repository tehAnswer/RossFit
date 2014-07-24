class CreateDiets < ActiveRecord::Migration
  def change
    create_table :diets do |t|
      t.string :name
      t.text :comment
      t.string :diet_type

      t.timestamps
    end
  end
end
