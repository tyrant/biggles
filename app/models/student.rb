class Student < User

  has_many :saved_profiles, 
    inverse_of: :saver, 
    foreign_key: :saver_id
  has_many :saved_tutors, 
    through: :saved_profiles, 
    inverse_of: :saved_students,
    source: :savee
  has_many :student_subjects, inverse_of: :student
  has_many :subjects, through: :student_subject, inverse_of: :students
  has_many :reviews, inverse_of: :reviewer, foreign_key: :reviewer_id

  def as_json(params={})
    super.deep_merge({
      data: {
        type: 'students',
        attributes: {},
        relationships: { 
          saved_profiles: {
            data: saved_profiles.map do |saved_profile|
                {
                  type: 'saved_profiles',
                  id: saved_profile.id,
                }
              end
          },
          saved_tutors: {
            data: saved_tutors.map do |saved_tutor|
                {
                  type: 'saved_tutors',
                  id: saved_tutor.id,
                }
              end
          },
          student_subjects: {
            data: student_subjects.map do |student_subject|
                {
                  type: 'student_subjects',
                  id: student_subject.id,
                }
              end
          },
          reviews: {
            data: reviews.map do |review|
                {
                  type: 'reviews',
                  id: review.id,
                }
              end
          },
        },
      }
    })
  end
end