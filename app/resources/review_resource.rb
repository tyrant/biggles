class ReviewResource < JSONAPI::Resource

  attributes :content, :rating, :created_at, :updated_at
  
  belongs_to :reviewer,
    class_name: 'Student',
    foreign_key: :reviewer_id
  belongs_to :reviewee,
    class_name: 'Tutor',
    foreign_key: :reviewee_id


end