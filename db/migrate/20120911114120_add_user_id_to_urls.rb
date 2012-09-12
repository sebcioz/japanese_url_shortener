class AddUserIdToUrls < ActiveRecord::Migration
  def change
    add_column :urls, :user_id, :string
  end
end
