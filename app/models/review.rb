class Review < ApplicationRecord

  belongs_to :reviewer, class_name: 'Student', inverse_of: :reviews
  belongs_to :reviewee, class_name: 'Tutor', inverse_of: :reviews
end