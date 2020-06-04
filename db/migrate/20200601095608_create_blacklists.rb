class CreateBlacklists < ActiveRecord::Migration[6.0]
  def change
    create_table :blacklists do |t|
      t.belongs_to :admin, null: false, index: true

      t.timestamps
    end
  end
end
