json.extract! nickname, :id, :conversation_id, :user_id, :name, :created_at, :updated_at
json.url nickname_url(nickname, format: :json)
