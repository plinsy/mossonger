class CreateConversations < ActiveRecord::Migration[6.0]
  def change
    create_table :conversations do |t|
      t.belongs_to :admin, null: false, index: true
      t.string :name, null: false
      t.boolean :receive_notifications_for_messages, null: false, default: true
      t.boolean :receive_notifications_for_reactions, null: false, default: true
      t.integer :max_users, null: false, default: 1

      t.timestamps
    end
  end
end
