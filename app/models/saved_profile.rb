class SavedProfile < ApplicationRecord

  belongs_to :saver, class_name: 'Student', inverse_of: :saved_profiles
  belongs_to :savee, class_name: 'Tutor', inverse_of: :saved_profiles
end