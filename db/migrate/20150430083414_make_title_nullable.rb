class MakeTitleNullable < ActiveRecord::Migration
  def change
    change_column :statuses, :title, :string, :null => true
  end
end
