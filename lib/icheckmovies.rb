require "nokogiri"
require "rest-client"

class Icheckmovies
  def initialize(url)
    @url = url
    @movie = Struct.new(:imdb_link, :title)
  end
  
  def self.fetch(url)
    Icheckmovies.new(url)
  end
  
  def movies
    content.css("li.movie").map do |movie|
      @movie.new(
        movie.at_css("a.optionIMDB").attr("href"),
        movie.at_css("h2 a").content
      )
    end
  end
    
  private
    def content
      @_content ||= Nokogiri::HTML(data)
    end
    
    def data
      @_data ||= RestClient.get(@url, timeout: 10)
    end
end
