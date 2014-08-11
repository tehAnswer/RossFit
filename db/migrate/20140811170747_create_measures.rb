class CreateMeasures < ActiveRecord::Migration
  def change
    create_table :measures do |t|
      t.integer :height
      t.decimal :weight
      t.belongs_to :user

      t.timestamps
    end
  end
end
