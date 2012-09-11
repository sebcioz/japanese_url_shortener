class AddClicksCountToUrls < ActiveRecord::Migration
  def change
    add_column :urls, :clicks_count, :integer
  end
end
