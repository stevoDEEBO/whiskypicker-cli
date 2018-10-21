require 'pry'
require_relative "whisky.rb"

#CLI Controller
class WhiskyPicker::CLI

  #include base path to append urls of whisky pages
  BASE_PATH="https://www.thewhiskyexchange.com"
  
  #welcome user to gem, call list search options, pick countries (and regions), display menu and exit!
  def call
    greet
    pick_whiskies
    country_list
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
    
  end
  
  #prompt user for country selection
  def country_list
    
  end
  
  