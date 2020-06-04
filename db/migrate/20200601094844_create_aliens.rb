class CreateAliens < ActiveRecord::Migration[6.0]
  def change
    create_table :aliens do |t|
      t.belongs_to :space, null: false, foreign_key: true
      t.references :muteable, polymorphic: true

      t.timestamps
    end
  end
end
