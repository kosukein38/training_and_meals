require 'rails_helper'

RSpec.describe 'Relationships', js: true do
  let(:user) { create(:user) }
  let(:other_users) { create_list(:user, 20) }

  before do
    other_users[0..9].each do |other_user|
      user.relationships.create!(followed_id: other_user.id)
      user.reverse_of_relationships.create!(follower_id: other_user.id)
    end
    login_as(user)
  end

  it 'ユーザーがフォローできること' do
    visit user_path(other_users.last.id)
    expect do
      click_on 'フォローする'
      expect(page).not_to have_link 'フォローする'
    end.to change(user.followings, :count).by(1)
  end

  it 'ユーザーがアンフォローできること' do
    visit user_path(other_users.first.id)
    expect do
      click_on 'フォロー解除'
      expect(page).not_to have_link 'フォロー解除'
    end.to change(user.followings, :count).by(-1)
  end
end
