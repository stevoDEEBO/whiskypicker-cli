require 'nokogiri'
require 'open-uri'
require 'pry'

class WhiskyPicker::Whiskyscraper
  attr_accessor :name, :profile_url, :country, :region_type, :proof, :rating, :description
  
  #scrape whisky type index page for name and url
  def scrape_whiskies
    profile_url = https://www.thewhiskyexchange.com/c/33/american-whiskey?filter=true&rfdata=~size.76#productlist-filter
    doc = Nokogiri::html(open(profile_url))
    
    binding pry

  end

end