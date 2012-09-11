require 'spec_helper'

describe UrlShortener, :type => :request, :driver => :url_shortener_driver do

  fixtures :urls

  it "should count clicks" do
    visit '/'

    3.times { all("#urls a")[0].click }
    1.times { all("#urls a")[1].click }

    all("#urls .clicks")[0].text.should == "3"
    all("#urls .clicks")[1].text.should == "1"
    all("#urls .clicks")[2].text.should == "0"
  end

  it "should save user agent" do
    visit '/'

    page.driver.browser.header("User-Agent", "Google Chrome")

    all("#urls a")[0].click

    all("#urls > *")[0].should have_content("Chrome")
  end

end