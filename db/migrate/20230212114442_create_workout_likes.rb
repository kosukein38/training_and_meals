class CreateWorkoutLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :workout_likes, id: :uuid do |t|
      t.references :workout, null: false, foreign_key: true, type: :uuid
      t.references :like, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
    add_index :workout_likes, [:workout_id, :like_id], unique: true
  end
end
