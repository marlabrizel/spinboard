class AddReadStatusToLinks < ActiveRecord::Migration
  def change
    add_column :links, :read_status, :boolean, null: false, default: false
  end
end
