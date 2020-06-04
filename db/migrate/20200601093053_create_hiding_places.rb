class CreateHidingPlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :hiding_places do |t|
      t.belongs_to :admin, null: false, index: true

      t.timestamps
    end
  end
end
