class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lastseenable

  has_many :language_users, inverse_of: :user
  has_many :languages, 
    through: :language_user,
    inverse_of: :users

  has_many :received_messages, class_name: 'Message', inverse_of: :messagee
  has_many :sent_messages, class_name: 'Message', inverse_of: :messager
end