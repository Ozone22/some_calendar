class AddRecurenceColumnsToEvent < ActiveRecord::Migration
  def change
    add_column :events, :repeat_type, :string, null: false, default: 'never'
    add_column :events, :schedule, :text
  end
end
