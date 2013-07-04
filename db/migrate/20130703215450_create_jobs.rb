class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :name
      t.text :description
      t.string :email
      t.string :company
      t.string :source_url
      t.integer :angellist_id
      t.timestamps
    end
  end
end
