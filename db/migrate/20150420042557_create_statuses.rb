class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string  :title, null: false
      t.string  :description, null: false
      t.boolean :anonymous

      t.references :user, index: true

      t.timestamps
    end
  end
end