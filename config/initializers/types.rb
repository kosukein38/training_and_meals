#require 'active_model/type'
Rails.application.config.to_prepare do
  ActiveModel::Type.register(:array, TypeArray)
end
