require 'spec_helper'

describe Url, :type => :request, :driver => :url_shortener_driver do
  before(:each) do
    Url.delete_all
    Click.delete_all
  end

  it "should shorten valid url" do
    valid_urls = ['http://google.pl', 'http://google.com/with/path', 'ftp://aasa@asad.pl:8080/path']

    valid_urls.each do |url|
      visit root_url

      fill_in 'url_target', :with => url
      click_button "Shorten url"

      page.should_not have_content 'Given url is invalid.'

      page.driver.stop_following_redirects
      all("#urls .short-url a").first.click
      page.driver.browser.last_response['Location'].should == url
      page.driver.follow_redirects
    end
  end

  it "should not shorten invalid url" do
    invalid_urls = ['test_string', '//a.pl', 'www.example.com']

    invalid_urls.each do |url|
      visit '/'
      fill_in 'url_target', :with => url
      click_button "Shorten url"

      page.should have_content 'Given url is invalid.'
      page.should_not have_selector("#urls li a")
    end
  end

  it "should list all correctly submited urls" do
    urls = ["http://google.pl", "http://example.com", "http://twitter.com"]

    urls.each do |url|
      visit '/'
      fill_in 'url_target', :with => url
      click_button "Shorten url"
    end

    visit '/'

    urls.each do |url|
      page.should have_content(url)
    end
  end
end
