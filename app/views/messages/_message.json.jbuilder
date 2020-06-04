json.extract! message, :id, :sender_id, :conversation_id, :content, :created_at, :updated_at
json.url message_url(message, format: :json)
