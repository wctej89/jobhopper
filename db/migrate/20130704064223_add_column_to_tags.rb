class AddColumnToTags < ActiveRecord::Migration
  def change
    add_column :tags, :tag_type, :string
  end
end
