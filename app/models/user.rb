class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :lastseenable, :jwt_authenticatable, jwt_revocation_strategy: JWTBlacklist

  has_many :language_users, inverse_of: :user
  has_many :languages, through: :language_users, inverse_of: :users
  has_many :received_messages, class_name: 'Message', inverse_of: :messagee
  has_many :sent_messages, class_name: 'Message', inverse_of: :messager
  belongs_to :postcode, inverse_of: :users, optional: true

  accepts_nested_attributes_for :language_users

  acts_as_mappable through: :postcode

  def as_json(params={})
    { 
      id: id,
      type: 'users',
      attributes: {
        email: email,
        name: name,
        sex: sex,
        age: age,
        last_seen: last_seen,
        created_at: created_at,
        updated_at: updated_at,
      },
      relationships: {
        language_users: {
          data: language_users.map do |language_user|
              {
                type: 'language_users',
                id: language_user.id,
              }
            end
        },
        postcode: { 
          data: if postcode 
              {
                type: 'postcodes',
                id: postcode.id 
              }
            else
              nil
            end
        }
      }
    }
  end
end