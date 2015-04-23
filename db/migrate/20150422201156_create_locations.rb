class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.decimal  :latitude, null: false
      t.decimal  :longitude, null: false

      t.references :status, index: true

      t.timestamps
    end
  end
end
