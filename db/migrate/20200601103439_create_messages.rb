class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.belongs_to :sender, null: false, index: true
      t.belongs_to :conversation, null: false, foreign_key: true
      t.text :content, null: false

      t.timestamps
    end
  end
end
