class CreateBodyParts < ActiveRecord::Migration[7.0]
  def change
    create_table :body_parts do |t|
      t.string :body_part_name, null: false

      t.timestamps
    end
  end
end
