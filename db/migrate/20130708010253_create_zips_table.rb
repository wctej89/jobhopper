class CreateZipsTable < ActiveRecord::Migration
  def up
    create_table :zips do |t|
      t.string :zip_code
      t.string :url
    end
  end

  def down
  end
end
