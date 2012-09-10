require 'spec_helper'

describe UrlShortener, :type => :request do
  it "should shorten valid url" do

    visit '/'
    fill_in 'url_target', :with => 'http://google.pl'
    click_button "Shorten url"

    page.driver.browser.extend(Module.new { def follow_redirects!() end })
    all("#urls li a").first.click
    page.driver.browser.last_response['Location'].should == 'http://google.pl'
  end
end
