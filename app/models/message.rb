class Message < ApplicationRecord

  belongs_to :messager,
    class_name: 'User',
    inverse_of: :sent_messages
  belongs_to :messagee,
    class_name: 'User',
    inverse_of: :received_messages

  validates :content, presence: true

  def as_json(params={})
    {
      data: { 
        id: id,
        type: 'messages',
        attributes: {
          content: content,
          seen_at: seen_at.to_s,
          created_at: created_at.to_s,
          updated_at: updated_at.to_s,
        },
        relationships: {
          messager: {
            data: {
              id: messager.id,
              type: 'user',
            }
          },
          messagee: {
            data: {
              id: messagee.id,
              type: 'user',
            }
          },
        }
      }
    }
  end
end