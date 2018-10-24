require 'nokogiri'
require 'open-uri'
require 'pry'

class WhiskyPicker::Whiskyscraper
  attr_accessor :name, :profile_url, :country, :region_type, :proof, :rating, :description
  
  #scrape whisky type index page for name and url
  def scrape_index_page
    profile_url = https://www.thewhiskyexchange.com/c/33/american-whiskey?filter=true&rfdata=~size.76#productlist-filter
    whiskies = []
    doc = Nokogiri::html(open(index_url))
    
    binding pry
    
    whisky_time = doc.css(".item a").attribute
    whisky_time.each do |whisky|
      my_whisky = self.new
      my_whisky.name = whisky.css("title").text.strip
      my_whisky.profile_url = whisky.css("href").value
      whiskies << my_whisky
    end
    whiskies
  end

end