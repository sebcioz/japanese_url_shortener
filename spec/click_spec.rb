require 'spec_helper'

describe Click, :type => :request, :driver => :url_shortener_driver do

  before(:each) do
    visit '/'

    ['http://google.pl', 'http://google.com/with/path', 'http://lol.pl:8080'].each do |url|
      fill_in 'url_target', :with => url
      click_button "Shorten url"
    end
  end

  it "should count clicks" do
    ignore_redirects(page) do
      3.times do
        all("#urls .short-url a")[0].click
        visit '/'
      end
      all("#urls .short-url a")[1].click
    end

    visit '/'

    all("#urls .clicks")[0].text.should == "3"
    all("#urls .clicks")[1].text.should == "1"
    all("#urls .clicks")[2].text.should == "0"
  end

  it "should save browser name" do
    page.driver.browser.header("User-Agent", 'Mozilla/5.0 (Windows; U; Windows NT 6.0; en-us) AppleWebKit/531.9 (KHTML, like Gecko) Version/4.0.3 Safari/531.9')

    ignore_redirects(page) do
      find("#urls .short-url a").click
    end

    visit '/'

    find("#urls .browsers").should have_content("Safari")
  end

end
