class User < ApplicationRecord
  authenticates_with_sorcery!
  validates :email, presence: true, uniqueness: true
  validates :name, length: { maximum: 30 }, presence: true

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :height, presence: true, on: :update
  validates :body_weight, presence: true, on: :update
  validates :age, presence: true, on: :update
  validates :sex, presence: true, on: :update
  validates :active_level, presence: true, on: :update

  enum sex: { male: 0, female: 1 }
  enum active_level: { level1: 1, level2: 2, level3: 3, level4: 4, level5: 5 }
end
