class AddProfilesToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :introduction,        :text
    add_column :users, :height,              :float
    add_column :users, :body_weight,         :float
    add_column :users, :age,                 :integer
    add_column :users, :sex,                 :integer
    add_column :users, :active_level,        :integer
    add_column :users, :target_weight,       :float
    add_column :users, :target_date,         :datetime
    add_column :users, :maintenance_calorie, :integer
    add_column :users, :adjustment_calorie,  :integer
    add_column :users, :target_calorie,      :integer
    add_column :users, :twitter_link,        :string
    add_column :users, :facebook_link,       :string
    add_column :users, :instagram_link,      :string
  end
end
