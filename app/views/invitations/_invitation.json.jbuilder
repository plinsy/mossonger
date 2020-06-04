json.extract! invitation, :id, :conversation_id, :guest_id, :message, :is_accepted, :created_at, :updated_at
json.url invitation_url(invitation, format: :json)
