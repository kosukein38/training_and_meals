class CreateMeals < ActiveRecord::Migration[7.0]
  def change
    create_table :meals, id: :uuid do |t|
      t.datetime :meal_date
      t.integer :meal_period
      t.integer :meal_type
      t.text :meal_memo
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
