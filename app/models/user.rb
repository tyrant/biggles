class User < ApplicationRecord
  include Rails.application.routes.url_helpers

  rolify

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, 
    :validatable, :lastseenable, :jwt_authenticatable, 
    jwt_revocation_strategy: JWTBlacklist

  has_many :language_users, inverse_of: :user
  has_many :languages, through: :language_users, inverse_of: :users
  has_many :received_messages, class_name: 'Message', inverse_of: :messagee
  has_many :sent_messages, class_name: 'Message', inverse_of: :messager
  belongs_to :postcode, inverse_of: :users, optional: true

  # User registration was straight-up ignoring :password_registration. Search me why.
  # https://stackoverflow.com/questions/15661815/devise-and-password-confirmation-validation 
  # covered how to add it again.
  validates :password_confirmation, presence: true, on: :create

  has_one_base64_attached :profile_image

  accepts_nested_attributes_for :language_users

  acts_as_mappable through: :postcode

  def as_json(params={})
    {
      data: { 
        id: id,
        type: 'users',
        attributes: {
          created_at: created_at,
          updated_at: updated_at,
          email: email,
          first_name: first_name,
          last_name: last_name,
          sex: sex,
          age: age,
          last_seen: last_seen,
          profile_image_path: if profile_image.blank?
              nil
            else
              rails_blob_path(profile_image, only_path: true)
            end
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
          postcode: if postcode.present? 
              { 
                data: {
                  type: 'postcodes',
                  id: postcode.id 
                }
              }
            end
        }
      },
      included: [
        if postcode.present?
          postcode.as_json
        end
      ]
    }
  end
end