class Message < ApplicationRecord

  belongs_to :messager, class_name: 'User', inverse_of: :sent_messages
  belongs_to :messagee, class_name: 'User', inverse_of: :received_messages
end