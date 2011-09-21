require "spec_helper"

describe Icheckmovies do
  use_vcr_cassette "the+best+1000+movies+ever+made"
  
  before(:each) do
    @check = Icheckmovies.fetch("http://www.icheckmovies.com/list/the+best+1000+movies+ever+made/")
  end
  
  it "should have 1002 movies" do
    @check.should have(1002).movies
  end
  
  it "should have some accessors" do
    @check.movies.each do |movie|
      movie.imdb_link.should match(%r{http://www.imdb.com/title/tt\d{7}/})
      movie.title.should_not be_empty
    end
  end
end