class AddTypeToStatus < ActiveRecord::Migration
  def change
    add_column :statuses, :status_type, :string
  end
end
