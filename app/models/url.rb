class Url < ActiveRecord::Base
  attr_accessible :target

  validates_presence_of :target
  validates_format_of :target, :with => URI::regexp(%w(http https ftp))

  validates_uniqueness_of :shortcut

  default_scope order("created_at DESC")

  has_many :clicks

  def generate_shortcut
    self.shortcut = Rufus::Mnemo.from_integer((rand * 10**6).to_i)
  end
end
