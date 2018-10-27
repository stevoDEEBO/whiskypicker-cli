require 'nokogiri'
require 'open-uri'
require 'pry'

class WhiskyPicker::Whiskyscraper
  attr_accessor :name, :profile_url, :country, :region_type, :proof, :rating, :description
  
  #scrape whisky type index page for name and url
  def self.scrape_index_page(index_url)
    whiskies = []
    doc = Nokogiri::HTML(open(index_url))
    
    whisky_time = doc.css(".item")
    whisky_time.each do |whisky|
      my_whisky = self.new
      my_whisky.name = whisky.css("a").attribute("title").text.strip
      my_whisky.profile_url = whisky.css("a").attribute("href").value
      whiskies << my_whisky
    end
    whiskies
  end

end