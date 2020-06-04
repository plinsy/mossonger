class CreateInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :invitations do |t|
      t.belongs_to :conversation, null: false, foreign_key: true
      t.belongs_to :guest, null: false, index: true
      t.text :message
      t.boolean :is_accepted, null: false, default: false

      t.timestamps
    end
  end
end
