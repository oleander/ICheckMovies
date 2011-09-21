require "nokogiri"
require "rest-client"

class Icheckmovies
  attr_reader :url
  
  def initialize(url)
    @url = url
    @movie = Struct.new(:imdb_link, :title, :year, :details)
  end
  
  def self.fetch(url)
    Icheckmovies.new(url)
  end
  
  def movies
    content.css("li.movie").map do |movie|
      @movie.new(
        movie.at_css("a.optionIMDB").attr("href"),
        movie.at_css("h2 a").content,
        movie.at_css(".year").content.to_i,
        "http://www.icheckmovies.com" + movie.at_css("a.dvdCoverSmall").attr("href")
      )
    end
  end
  
  def name
    @_name ||= content.at_css("h1").content
  end
    
  private
    def content
      @_content ||= Nokogiri::HTML(data)
    end
    
    def data
      @_data ||= RestClient.get(@url, timeout: 10)
    end
end
