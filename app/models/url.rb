class Url < ActiveRecord::Base

  has_many :clicks

  attr_accessible :target

  validates_presence_of :shortcut
  validates_uniqueness_of :shortcut

  validates_presence_of :target
  validates_format_of :target, :with => URI::regexp(%w(http https ftp))

  default_scope order("created_at DESC")

  def create_shortcut
    new_shortcut = generate_shortcut

    while self.class.where(:shortcut => new_shortcut).present?
      new_shortcut = generate_shortcut
    end

    self.shortcut = new_shortcut
  end

  def click!(agent)
    self.clicks.create(:browser => agent.name)
  end

  private

  def generate_shortcut
    Rufus::Mnemo.from_integer((rand * 10**6).to_i)
  end
end
