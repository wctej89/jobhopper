class AddIndexesToDbTables < ActiveRecord::Migration
  def change
    add_index :jobs, :id
    add_index :jobs, :name
    add_index :jobs, :city_id
    add_index :cities, :id
    add_index :cities, :latitude
    add_index :cities, :longitude
    add_index :job_tags, :id
    add_index :job_tags, :job_id
    add_index :job_tags, :tag_id
    add_index :tags, :id
    add_index :tags, :name
  end
end
