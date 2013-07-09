class AddStatusToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :read, :string
  end
end
