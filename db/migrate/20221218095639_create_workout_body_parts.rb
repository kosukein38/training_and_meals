class CreateWorkoutBodyParts < ActiveRecord::Migration[7.0]
  def change
    create_table :workout_body_parts do |t|
      t.references :workout, null: false, foreign_key: true
      t.references :body_part, null: false, foreign_key: true

      t.timestamps
    end
  end
end
