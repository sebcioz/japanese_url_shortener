class AddIndexes < ActiveRecord::Migration
  def up
    add_index :urls, :shortcut
    add_index :clicks, :url_id
  end

  def down
  end
end
