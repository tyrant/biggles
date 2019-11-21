class TutorAvailability < ApplicationRecord

  belongs_to :tutor, inverse_of: :tutor_availabilities
  belongs_to :availability, inverse_of: :tutor_availabilities

  def as_json(params={})
    {
      id: 'id',
      type: 'tutor_availabilities',
      attributes: {},
      relationships: {
        tutor: {
          data: {
            id: tutor.id,
            type: 'tutors',
          }
        },
        availability: {
          data: {
            id: availability.id,
            type: 'availabilities'
          }
        }
      }
    }
  end
end