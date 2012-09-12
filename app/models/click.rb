class Click < ActiveRecord::Base
  belongs_to :url, :counter_cache => true

  attr_accessible :browser
end
