require 'nokogiri'
require 'open-uri'
require 'pry'

class WhiskyPicker::Whiskyscraper
  attr_accessor :name, :profile_url, :country, :region_type, :proof, :rating, :description
  
  #scrape whisky type index page for name and url
  def self.scrape_index_page(index_url)
    whiskies = []
    index = Nokogiri::HTML(open(index_url))
    
    whisky_time = index.css(".item")
    whisky_time.each do |whisky|
      my_whisky = self.new
      my_whisky.name = whisky.css("a").attribute("title").text.strip
      my_whisky.profile_url = whisky.css("a").attribute("href").value
      whiskies << my_whisky
    end
    whiskies
  end

  def self.scrape_profile_page(profile_url)
    
    profile = Nokogiri::HTML(open(profile_url))
    
    whisky = profile.css("container")
    
    my_whisky = self.new
    my_whisky.name = whisky.css("name-container h1").text.strip
    my_whisky.country = whisky.css("dl.meta").at('dt:contains("Country")').next_element.text.strip if whisky.css("dl.meta").at('dt:contains("Country")') != nil
    my_whisky.region_type = whisky.css("name-container ul.properties li").text.strip
    my_whisky.proof = whisky.css("name-container span.strength").text.strip.split(" / ").last
    my_whisky.rating = whisky.css("rating-container span").text
    my_whisky.description = whisky.css(".details-content-item").text.strip
    
    my_whisky
  end

end