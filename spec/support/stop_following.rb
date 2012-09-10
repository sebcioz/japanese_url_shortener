class UrlShortener::Driver < Capybara::RackTest::Driver
  def initialize(app, options = {})
    super

    @follow_redirects = true
  end

  def browser
    @browser ||= UrlShortener::Browser.new(self)
  end

  def follow_redirects?
    @follow_redirects
  end

  def follow_redirects
    @follow_redirects = true
  end

  def follow_redirects!
    @follow_redirects = true
    browser.follow_redirects!
  end

  def stop_following_redirects
    @follow_redirects = false
  end
end

class UrlShortener::Browser < Capybara::RackTest::Browser
  def follow_redirects!
    super if driver.follow_redirects?
  end
end

Capybara.register_driver :url_shortener_driver do |app|
  UrlShortener::Driver.new app
end
