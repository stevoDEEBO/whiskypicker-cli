require 'pry'
require_relative "whiskyscraper.rb"
require 'colorize'

#CLI Controller
class WhiskyPicker::CLI

  #include base path to append urls of whisky pages
  BASE_PATH="https://www.thewhiskyexchange.com/"

  #welcome user to gem, pick a whisky and exit!
  def call
    greet
    pick_whiskies
    menu
    laters
  end

  #greet user
  def greet
    puts "Welcome to Whisky Picker...ready to pick yer whisky?"
    puts ""
  end

  #list search options
  def pick_whiskies
    country_select
  end

  #list countries and prompt user for country selection
  def country_select
    puts "Which country would you like to explore?"
    puts <<-DOC
    1. Scotland
    2. Irelend
    3. USA
    4. Japan
    5. Canada
    6. Other
    DOC

    input = nil
    while input != "exit"
      puts "Please enter number of desired country"
      input = gets.strip.downcase
      case input
      when "1"
        scotch
        break
      when "2"
        irish
        break
      when "3"
        american
        break
      when "4"
        japanese
        break
      when "5"
        canadian
        break
      when "6"
        other
        break
      when "start"
        country_select
        break
      when "exit"
        laters
        exit
      else
        puts "Didn't quite catch that, please type number of desired country, type start  or exit to leave."
      end
    end
  end

  #scotch section has an additional drill down by type of Scotch in order to find list of Scotch whiskies
  #list search options by type of Scotch whiskies here and prompt user for type of Scotch selection
  def scotch
    puts "Which type of Scotch would you like to explore?"
    puts <<-DOC
    1. Single Malt
    2. Blended Malt
    3. Blended
    4. Grain
    DOC

    #prompt user for desired type of scotch whisky selection
    input = nil
    while input != "exit"
      puts "Please enter the number of desired type of scotch or type list, back or exit to leave."
      input = gets.strip.downcase
      case input
      when "1"
        scotch_single_malt
        break
      when "2"
        scotch_blended_malt
        break
      when "3"
        scotch_blended
        break
      when "4"
        scotch_grain
        break
      when "back"
        scotch
        break
      when "start"
        country_select
        break
      when "exit"
        laters
        exit
      else
        puts "Didn't quite catch that, please enter number of desired type of Scotch, type list or exit to leave."
      end
    end
  end

  #show list of single malt Scotch whiskies
  def scotch_single_malt
    puts "Let's explore single malt Scotch whiskies"
    #call method to list whiskies for this particular type
    whisky_list('c/40/single-malt-scotch-whisky?filter=true&rfdata=~size.76#productlist-filter')
  end

  #show list of blended malt Scotch whiskies
  def scotch_blended_malt
    puts "Let's explore blended malt Scotch whiskies"
    #call method to list whiskies for this particular type
    whisky_list('c/309/blended-malt-scotch-whisky?filter=true&rfdata=~size.76#productlist-filter')
  end

  #show list of blended Scotch whiskies
  def scotch_blended
    puts "Let's explore blended Scotch whiskies"
    #call method to list whiskies for this particular type
    whisky_list('c/304/blended-scotch-whisky?filter=true&rfdata=~size.76#productlist-filter')
  end

  #show list of grain Scotch whiskies
  def scotch_grain
    puts "Let's explore grain Scotch whiskies"
    #call method to list whiskies for this particular type
    whisky_list('c/310/grain-scotch-whisky?filter=true&rfdata=~size.76#productlist-filter')
  end

  #show list of Irish whiskies
  def irish
    puts "Let's explore Irish whiskies"
    #call method to list whiskies for this particular type
    whisky_list('c/32/irish-whiskey?filter=true&rfdata=~size.76#productlist-filter')
  end

  #show list of American whiskies
  def american
    puts "Let's explore American whiskies"
   #call method to list whiskies for this particular type
    whisky_list('c/33/american-whiskey?filter=true&rfdata=~size.76#productlist-filter')
  end

  #show list of Japanese whiskies
  def japanese
    puts "Let's explore Japanese whiskies"
    #call method to list whiskies for this particular type
    whisky_list('c/35/japanese-whisky?filter=true&rfdata=~size.76#productlist-filter')
  end

  #show list of Canadian whiskies
  def canadian
    puts "Let's explore Canadian whiskies"
    #call method to list whiskies for this particular type
    whisky_list('c/34/canadian-whisky?filter=true&rfdata=~size.76#productlist-filter')
  end

  #show list of whiskies from other countries
  def other
    puts "Let's explore whiskies from other countries"
    #call method to list whiskies for this particular type
    whisky_list('c/305/rest-of-the-world-whisky?filter=true&rfdata=~size.76#productlist-filter')
  end

  #display list of whiskies for selected country by using scraper to do this
  #by creating array of scraped whiskies and hashes for each individual whisky
  def whisky_list(whisky_url)
    #scrape and create whisky hashes for all selected whiskies using urls
    @whiskies = WhiskyPicker::Whiskyscraper.scrape_index_page(BASE_PATH + whisky_url)
    #display list of whiskies
    @whiskies.each_with_index do |whisky, index|
      puts "#{index+1}. #{whisky.name}"
    end
 #   menu
  end

  #display menu results with details about selected whisky
  def menu
    input = nil
    while input != 'exit'
      puts "Please enter the number of the particular whisky you would like."
      input = gets.strip.downcase

      if input.to_i > 0 && input.to_i <= @whiskies.size
        whisky = @whiskies[input.to_i-1]
#binding.pry
        #have scraper scrape profile page for selected whisky
        whisky = WhiskyPicker::Whiskyscraper.scrape_profile_page(BASE_PATH + whisky.profile_url)

        #display selected whisky profile info
        puts "Name: " + "#{whisky.name}".upcase.colorize(:color => :blue)
        puts ""
        puts "Country: " + "#{whisky.country}".colorize(:light_blue)
        puts "Region & Type: " + "#{whisky.region_type}".colorize(:cyan)
        puts "Proof: " + "#{whisky.proof}".colorize(:green)
        if whisky.rating == ""
          puts "Customer rating: " + ("unrated").colorize(:green)
        else
          puts "Customer rating: " + ("#{whisky.rating}" + "/5 stars").colorize(:green)
        end
        puts "Description: " + "#{whisky.description}".colorize(:yellow)
        puts ""
        puts ""

        next_step
      end
    end
  end

  def next_step
    puts "Want to pick another one? Type back to return to most recent list, start to start over or exit to leave."

    input = gets.strip.downcase
    if input == "start" || input == "restart" || input == "top"
      pick_whiskies
    elsif input == "exit" || input == "bye"
      laters
    elsif input == "back" || input == "list" || input == "yes" || input == "y"
      @whiskies.each_with_index do |whisky, index|
        puts "#{index+1}. #{whisky.name}"
      end
    else
      next_step
    end
  end

  #exit CLI
  def laters
    puts "Laters! Thanks for stopping by."
    exit
  end
end
