class CreateCondemneds < ActiveRecord::Migration[6.0]
  def change
    create_table :condemneds do |t|
      t.belongs_to :blacklist, null: false, foreign_key: true
      t.references :blockable, polymorphic: true

      t.timestamps
    end
  end
end
