class Url < ActiveRecord::Base
  attr_accessible :shortcut, :target

  def generate_shortcut(int)
    self.shortcut = Rufus::Mnemo.from_integer(int)
  end
end
