require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/")) 
    get_students = doc.css(".student-card")
    @students = []
    get_students.each do |student|
      student_hash = Hash.new  
      student_hash[:name] = student.css(".student-name").text
      student_hash[:location] = student.css(".student-location").text
      student_hash[:profile_url] = student.css("a").attribute("href").value
      @students << student_hash
    end
    @students
  end

  def self.scrape_profile_page(profile_url)
    @students.each do |student|
      doc = Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/#{student[:profile_url]}"))
      info_hash = Hash.new
      get_socials = doc.css(".social-icon-container").css("a")
      get_socials.each do |icon|
        #binding.pry
        parsed_src = icon.css("img").attribute("src").value.delete_suffix("-icon.png").slice(14)
        info_hash[parsed_src] = icon.css("a").attribute("href").value
      end
    end
  info_hash
  
    
  end



end



