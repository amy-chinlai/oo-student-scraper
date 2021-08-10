require 'open-uri'
require 'pry'
require 'nokogiri'
require 'watir'

class Scraper

  def self.scrape_index_page(index_url)
  browser = Watir::Browser.new
        browser.goto("https://www.mobilize.us/?address=20010&lat=38.9339046&lon=-77.03053899999999&show_all_events=true")
        doc = Nokogiri::HTML(browser.html)

        opportunities_list = []
        doc.css(".e1olnexu8").each do |section|
            opportunities_list << section
        end

        @opportunities = []
        opportunities_list.each do |opportunity|
            info_hash = Hash.new
            info_hash[:name] = opportunity.css(".css-1i6gh54").text
            info_hash[:date] = opportunity.css(".e1olnexu5").text
            info_hash[:location] = opportunity.css(".e1olnexu14").text
            info_hash[:link] = opportunity.css(".e1olnexu1").attribute("href").text
            @opportunities << info_hash
        end
        @opportunities
  end

  # def self.scrape_profile_page(profile_url)
  #     doc = Nokogiri::HTML(open(profile_url))
  #     info_hash = Hash.new
  #     # socials
  #     get_socials = doc.css(".social-icon-container a")
  #     get_socials.map do |icon|
  #       parsed_src = icon.css("img").attribute("src").value.delete_suffix("-icon.png").delete_prefix("../assets/img/")
  #       info_hash[parsed_src] = icon.attribute("href").value
  #     end

  #     vitals = doc.css(".vitals-text-container")
  #     details = doc.css(".details-container")
  #     info_hash[:profile_quote] = vitals.css(".profile-quote").text
  #     info_hash[:bio] = details.css(".description-holder p").text
      
  #   symbolized_hash = info_hash.transform_keys(&:to_sym)
  #   symbolized_hash[:blog] = symbolized_hash.delete :rss if symbolized_hash[:rss]
  #   symbolized_hash
  # end

   #     opportunities_list = doc.css(".e1olnexu8")
    # @opportunites = []
    # opportunities_list.each do |opportunity|
    #     info_hash = Hash.new
    #     binding.pry
    #     # info_hash[:name] = doc.css(".css-1i6gh54")
    #     # info_hash[:date] = doc.css(".e1olnexu5")
    #     # info_hash[:location] = doc.css(".e1olnexu14")
    #     info_hash[:link] = doc.css(".e1olnexu1").attribute("href").value
    #     @opportunities << info_hash



end
