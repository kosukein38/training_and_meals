class WorkoutForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :workout_date, :datetime
  attribute :workout_title, :string
  attribute :workout_time, :integer
  attribute :workout_weight, :float
  attribute :repetition_count, :integer
  attribute :set_count, :integer
  attribute :workout_memo, :string
  attribute :body_part_ids
  attribute :workout_images
  attribute :user_id
  # attribute :workout_id

  validates :workout_date, presence: true
  validates :workout_title, presence: true
  validates :body_part_ids, presence: true
  validates :workout_time, presence: true
  validates :workout_weight, presence: true
  validates :repetition_count, presence: true
  validates :set_count, presence: true

  delegate :persisted?, to: :workout

  def initialize(attributes = nil, workout: Workout.new)
    @workout = workout
    attributes ||= default_attributes
    super(attributes)
  end


  def save
    return false if invalid?
    ActiveRecord::Base.transaction do
      workout.update!(workout_date:, workout_title:, workout_time:,
                      workout_weight:, repetition_count:, set_count:, workout_memo:, user_id:, workout_images:)
      debugger
      body_part_ids.each do |body_part_id|
        WorkoutBodyPart.find_or_create_by!(workout_id: workout.id, body_part_id:)
      end
    end
  rescue ActiveRecord::RecordInvalid
    false
  end


  def to_model
    workout
  end

  private

  attr_reader :workout

  def default_attributes
    {
      user_id: workout.user_id,
      workout_date: workout.workout_date,
      workout_title: workout.workout_title,
      workout_date: workout.workout_title,
      workout_time: workout.workout_time,
      workout_weight: workout.workout_weight,
      repetition_count: workout.repetition_count,
      set_count: workout.set_count,
      workout_memo: workout.workout_memo,
      workout_images: workout.workout_images,
      body_part_ids: workout.body_parts.pluck(:id)
    }
  end






  # def update
  #   return false if invalid?

  #   workout = Workout.find(workout_id)
  #   workout.update!(workout_date:, workout_title:, workout_time:, workout_weight:, repetition_count:, set_count:, workout_memo:,
  #                   workout_images:, user_id:)
  #   body_part_ids.map(&:to_i).each do |body_part_id|
  #     next if WorkoutBodyPart.find_by(workout_id:, body_part_id:)

  #     WorkoutBodyPart.create(workout_id:, body_part_id:)
  #   end
  # end
end
