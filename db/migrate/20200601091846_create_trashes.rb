class CreateTrashes < ActiveRecord::Migration[6.0]
  def change
    create_table :trashes do |t|
      t.belongs_to :dropbox, null: false, foreign_key: true
      t.references :trashable, polymorphic: true

      t.timestamps
    end
  end
end
