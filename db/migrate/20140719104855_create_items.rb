class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.decimal :calories
      t.decimal :fat
      t.decimal :carbohydrates
      t.decimal :protein
      t.text :description
      t.string :item_type

      t.timestamps
    end
  end
end
