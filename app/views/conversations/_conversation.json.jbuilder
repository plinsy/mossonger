json.extract! conversation, :id, :admin_id, :name, :receive_notifications_for_messages, :receive_notifications_for_reactions, :created_at, :updated_at
json.url conversation_url(conversation, format: :json)
