class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.text :target
      t.string :shortcut

      t.timestamps
    end
  end
end
