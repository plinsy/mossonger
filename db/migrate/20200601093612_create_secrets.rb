class CreateSecrets < ActiveRecord::Migration[6.0]
  def change
    create_table :secrets do |t|
      t.belongs_to :hiding_place, null: false, foreign_key: true
      t.references :hideable, polymorphic: true

      t.timestamps
    end
  end
end
