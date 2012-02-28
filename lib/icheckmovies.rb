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

    unless @_movies

      #current page movies
      @_movies = content.css("li.movie").map do |movie|
        @movie.new(
          movie.at_css("a.optionIMDB").attr("href"),
          movie.at_css("h2 a").content,
          movie.at_css("a.tagNamespaceYear").content.to_i,
          "http://www.icheckmovies.com" + movie.at_css("a.dvdCoverSmall").attr("href"),
          movie.at_css("a.optionIMDB").attr("href").match(/(tt\d{7})/).to_a[1],
          movie.at_css(".rank") ? movie.at_css(".rank").content.to_i : 0
        )
      end

      #get next pages content when multiple pages
      if content.css("li.next").at_css("a")
        query_string = content.css("li.next").at_css("a").attr("href")
        base_url = url.match(/([^?]*)/).to_s
        next_page = ICheckMovies.fetch(base_url + query_string)
        @_movies.concat(next_page.movies)
      end

    end

    @_movies

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
