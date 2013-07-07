class AddColumnToUserTags < ActiveRecord::Migration
  def change
    add_column :user_tags, :applied, :boolean, default: false
  end
end
