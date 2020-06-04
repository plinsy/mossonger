class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.belongs_to :sender, null: false, index: true
      t.belongs_to :friend, null: false, index: true
      t.boolean :is_accepted, null: false, default: false
      t.boolean :is_paused, null: false, default: false

      t.timestamps
    end
  end
end
