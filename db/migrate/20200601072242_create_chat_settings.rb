class CreateChatSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :chat_settings do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.boolean :active_status, null: false, default: false
      t.boolean :enable_sounds, null: false, default: false
      t.boolean :enable_notifications, null: false, default: false

      t.timestamps
    end
  end
end
