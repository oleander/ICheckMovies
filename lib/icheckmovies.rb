require "nokogiri"
require "rest-client"

class ICheckMovies
  attr_reader :url
  
  def initialize(url)
    @url = url
    @movie = Struct.new(:imdb_link, :title, :year, :details, :id, :order)
  end
  
  def self.fetch(url)
    ICheckMovies.new(url)
  end
  
  def movies
    @_movies ||= content.css("li.movie").map do |movie|
      @movie.new(
        movie.at_css("a.optionIMDB").attr("href"),
        movie.at_css("h2 a").content,
        movie.at_css(".year").content.to_i,
        "http://www.icheckmovies.com" + movie.at_css("a.dvdCoverSmall").attr("href"),
        movie.at_css("a.optionIMDB").attr("href").match(/(tt\d{7})/).to_a[1],
        movie.at_css(".rank").content.to_i
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
