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
  attribute :body_part_name, :string
  attribute :user_id, :integer
  attribute :workout_id, :integer

  validates :body_part_name, presence: true

  def save
    return false if invalid?
    body_part_id = BodyPart.find_by(body_part_name: body_part_name).id
    workout = Workout.create(workout_date: workout_date, workout_title: workout_title, workout_time: workout_time, workout_weight: workout_weight, repetition_count: repetition_count, set_count: set_count, workout_memo: workout_memo, user_id: user_id)
    WorkoutBodyPart.create(workout_id: workout.id, body_part_id: body_part_id)
  end
end
