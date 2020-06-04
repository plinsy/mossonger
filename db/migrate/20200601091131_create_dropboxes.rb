class CreateDropboxes < ActiveRecord::Migration[6.0]
  def change
    create_table :dropboxes do |t|
      t.belongs_to :admin, null: false, index: true

      t.timestamps
    end
  end
end
