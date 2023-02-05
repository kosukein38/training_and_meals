class CreateRelationships < ActiveRecord::Migration[7.0]
  def change
    create_table :relationships, id: :uuid do |t|
      t.uuid :follower_id
      t.uuid :followed_id

      t.timestamps
    end
    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
    add_index :relationships, [:follower_id, :followed_id], unique: true
  end
end
