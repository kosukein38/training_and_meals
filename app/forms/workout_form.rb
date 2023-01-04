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
  attribute :user_id, :integer
  attribute :workout_id, :integer

  validates :workout_date, presence: true
  validates :workout_title, presence: true
  validates :body_part_ids, presence: true
  validates :workout_time, presence: true
  validates :workout_weight, presence: true
  validates :repetition_count, presence: true
  validates :set_count, presence: true

  def save
    return false if invalid?

    workout = Workout.create(workout_date:, workout_title:, workout_time:,
                             workout_weight:, repetition_count:, set_count:, workout_memo:, workout_images:, user_id:)
    body_part_ids.map(&:to_i).each do |body_part_id|
      WorkoutBodyPart.create(workout_id: workout.id, body_part_id:)
    end
  end

  def update 
    return false if invalid?

    workout = Workout.find(workout_id)
    workout.update!(workout_date:, workout_title:, workout_time:, workout_weight:, repetition_count:, set_count:, workout_memo:,
                    workout_images:, user_id:)
    body_part_ids.map(&:to_i).each do |body_part_id|
      next if WorkoutBodyPart.find_by(workout_id:, body_part_id:)

      WorkoutBodyPart.create(workout_id:, body_part_id:)
    end
  end
end
