class MealForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :meal_date, :datetime
  attribute :meal_period, :integer
  attribute :meal_type, :integer
  attribute :meal_memo, :string
  attribute :user_id
  attribute :meal_title_first, :string
  attribute :meal_weight_first, :integer
  attribute :meal_calorie_first, :integer
  attribute :meal_title_second, :string
  attribute :meal_weight_second, :integer
  attribute :meal_calorie_second, :integer
  attribute :meal_title_third, :string
  attribute :meal_weight_third, :integer
  attribute :meal_calorie_third, :integer
  attribute :meal_images

  validates :meal_date, presence: true
  validates :meal_title_first, presence: true
  validates :meal_weight_first, presence: true
  validates :meal_calorie_first, presence: true

  delegate :persisted?, to: :meal

  def initialize(attributes = nil, meal: Meal.new)
    @meal = meal
    attributes ||= default_attributes
    super(attributes)
  end

  def save
    return false if invalid?

    ActiveRecord::Base.transaction do
      if meal.meal_images.blank?
        meal.update!(meal_date:, meal_period:, meal_type:, meal_memo:, user_id:, meal_images:)
      else
        meal.update!(meal_date:, meal_period:, meal_type:, meal_memo:, user_id:)
      end

      if meal.meal_details.blank?
        meal.meal_details.create!(meal_title: meal_title_first, meal_weight: meal_weight_first, meal_calorie: meal_calorie_first)
      else
        meal.meal_details.update!(meal_title: meal_title_first, meal_weight: meal_weight_first, meal_calorie: meal_calorie_first)
      end

      unless meal_title_second.empty?
        meal.meal_details.build(meal_title: meal_title_second, meal_weight: meal_weight_second,
                                meal_calorie: meal_calorie_second).save!
      end

      unless meal_title_third.empty?
        meal.meal_details.build(meal_title: meal_title_third, meal_weight: meal_weight_third,
                                meal_calorie: meal_calorie_third).save!
      end
    end
  rescue ActiveRecord::RecordInvalid
    false
  end

  def to_model
    meal
  end

  private

  attr_reader :meal

  def default_attributes
    meal_title_first = meal.meal_details.first.nil? ? '' : meal.meal_details.first.meal_title
    meal_weight_first = meal.meal_details.first.nil? ? '' : meal.meal_details.first.meal_weight
    meal_calorie_first = meal.meal_details.first.nil? ? '' : meal.meal_details.first.meal_calorie
    meal_title_second = meal.meal_details.second.nil? ? '' : meal.meal_details.second.meal_title
    meal_weight_second = meal.meal_details.second.nil? ? '' : meal.meal_details.second.meal_weight
    meal_calorie_second = meal.meal_details.second.nil? ? '' : meal.meal_details.second.meal_calorie
    meal_title_third = meal.meal_details.third.nil? ? '' : meal.meal_details.third.meal_title
    meal_weight_third = meal.meal_details.third.nil? ? '' : meal.meal_details.third.meal_weight
    meal_calorie_third = meal.meal_details.third.nil? ? '' : meal.meal_details.third.meal_calorie
    {
      user_id: meal.user_id,
      meal_date: meal.meal_date,
      meal_period: meal.meal_period_before_type_cast,
      meal_type: meal.meal_period_before_type_cast,
      meal_memo: meal.meal_memo,
      meal_images: meal.meal_images,
      meal_title_first:,
      meal_weight_first:,
      meal_calorie_first:,
      meal_title_second:,
      meal_weight_second:,
      meal_calorie_second:,
      meal_title_third:,
      meal_weight_third:,
      meal_calorie_third:
    }
  end
end
