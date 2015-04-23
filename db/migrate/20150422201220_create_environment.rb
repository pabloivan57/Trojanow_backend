class CreateEnvironment < ActiveRecord::Migration
  def change
    create_table :environments do |t|
      t.decimal  :temperature, null: false

      t.references :status, index: true

      t.timestamps
    end
  end
end
