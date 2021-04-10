class SavedProfile < ApplicationRecord

  belongs_to :saver, 
    class_name: 'Student', 
    inverse_of: :saved_profiles, 
    foreign_key: :saver_id
  belongs_to :savee, 
    class_name: 'Tutor', 
    inverse_of: :saved_profiles,
    foreign_key: :savee_id

  def as_json(params={})
    {
      data: {
        id: id,
        type: 'saved_profiles',
        attributes: {},
        relationships: {
          saver: {
            data: {
              id: saver.id,
              type: 'students',
            }
          },
          savee: {
            data: {
              id: savee.id,
              type: 'tutors',
            }
          }
        }
      }
    }
  end
end