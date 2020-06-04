class CreateNicknames < ActiveRecord::Migration[6.0]
  def change
    create_table :nicknames do |t|
      t.belongs_to :conversation, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
