json.extract! friendship, :id, :sender_id, :friend_id, :is_accepted, :is_paused, :created_at, :updated_at
json.url friendship_url(friendship, format: :json)
