class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id, null: false
      t.datetime :start_date, null: false
      t.string :name, null: false
      t.timestamps null: false
    end
  end
end
