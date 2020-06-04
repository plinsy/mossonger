json.extract! chat_setting, :id, :user_id, :active_status, :enable_sounds, :enable_notifications, :created_at, :updated_at
json.url chat_setting_url(chat_setting, format: :json)
