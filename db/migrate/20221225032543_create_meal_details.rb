class CreateMealDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :meal_details, id: :uuid do |t|
      t.string :meal_title,   null: false
      t.integer :meal_weight, null: false
      t.integer :meal_calorie,     null: false
      t.references :meal,     null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
