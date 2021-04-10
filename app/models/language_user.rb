class LanguageUser < ApplicationRecord

  belongs_to :language, inverse_of: :language_users
  belongs_to :user, inverse_of: :language_users

  def as_json(params={})
    {
      data: {
        id: id,
        type: 'language_users',
        attributes: {},
        relationships: {
          language: {
            data: {
              id: language.id,
              type: 'languages',
            }
          },
          user: {
            data: {
              id: user.id,
              type: 'users'
            }
          }
        }
      }
    }
  end
end