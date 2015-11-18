class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :title
      t.string :valid_url

      t.timestamps null: false
    end
  end
end
