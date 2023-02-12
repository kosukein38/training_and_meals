class CreateMealLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :meal_likes, id: :uuid do |t|
      t.references :meal, null: false, foreign_key: true, type: :uuid
      t.references :like, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
    add_index :meal_likes, [:meal_id, :like_id], unique: true
  end
end
