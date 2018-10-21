require 'pry'
require_relative "whisky.rb"

#CLI Controller
class WhiskyPicker::CLI

  #include base path to append urls of whisky pages
  BASE_PATH="https://www.thewhiskyexchange.com"
  
  #welcome user to gem, pick a whisky and exit!
  def call
    greet
    pick_whiskies
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
    whisky_list
    menu
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
      when "2"
        irish
      when "3"
        american
      when "4"
        japanese
      when "5"
        canadian
      when "6"
        other
      else puts "Didn't quite catch that, please type number of desired country"
  end
  
  #display list of whiskies for selected country and prompt user for specific whisky
  def whisky_list
    
  end

  #display menu results with details about selected whisky
  def menu
    
  end
  
  #exit CLI
  def laters
    puts "Laters! Thanks for stopping by."
    exit
  end