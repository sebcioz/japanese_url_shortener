require 'spec_helper'

describe Url, :type => :request, :driver => :url_shortener_driver do
  VALID_URLS = ['http://google.pl', 'http://google.com/with/path', 'ftp://aasa@asad.pl:8080/path']
  INVALID_URLS = ['test_string', '//a.pl', 'www.example.com']

  it "should shorten valid url" do
    VALID_URLS.each do |url|
      visit '/'

      fill_in 'url_target', :with => url
      click_button "Shorten url"

      page.should have_content 'Url shortened.'

      ignore_redirects(page) do
        find("#urls .short-url a").click
      end

      page.driver.browser.last_response['Location'].should == url
    end
  end

  it "should not shorten invalid url" do
    INVALID_URLS.each do |url|
      visit '/'
      fill_in 'url_target', :with => url
      click_button "Shorten url"

      page.should have_content 'Given url is invalid.'
      page.should_not have_selector("#urls .short-url a")
    end
  end

  it "should list only current user's urls" do
    VALID_URLS.each do |url|
      visit '/'
      fill_in 'url_target', :with => url
      click_button "Shorten url"
    end

    visit '/'
    all("#urls .short-url a").count.should == 3

    Capybara.reset_session!

    visit '/'
    all("#urls .short-url a").count.should == 0
  end

end
