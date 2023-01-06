class CreateWorkouts < ActiveRecord::Migration[7.0]
  def change
    create_table :workouts, id: :uuid do |t|
      t.datetime :workout_date
      t.string :workout_title
      t.integer :workout_time
      t.float :workout_weight
      t.integer :repetition_count
      t.integer :set_count
      t.text :workout_memo
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
