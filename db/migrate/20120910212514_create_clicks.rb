class CreateClicks < ActiveRecord::Migration
  def change
    create_table :clicks do |t|
      t.integer :url_id
      t.text :browser

      t.timestamps
    end
  end
end
