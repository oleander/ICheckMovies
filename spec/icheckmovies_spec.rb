require "spec_helper"

describe ICheckMovies do
  use_vcr_cassette "the+best+1000+movies+ever+made"
  let(:href_matcher) { %r{^((http[s]?|ftp):\/)?\/?([^:\/\s]+)((\/\w+)*\/)([\w\-\.]+[^#?\s]+)(.*)?(#[\w\-]+)?$} }
  let(:url) { "http://www.icheckmovies.com/list/the+best+1000+movies+ever+made/" }
  
  before(:each) do
    @check = ICheckMovies.fetch(url)
  end
  
  it "should have 1002 movies" do
    @check.should have(1002).movies
  end
  
  it "should have some accessors" do
    @check.movies.each_with_index do |movie, index|
      movie.imdb_link.should match(%r{http://www.imdb.com/title/tt\d{7}/})
      movie.title.should_not be_empty
      movie.year.should > 1800
      movie.details.should match(href_matcher)
      movie.id.should match(/^tt\d{7}$/)
      movie.order.should eq(index + 1)
    end
  end
  
  it "should be able to return the given url" do
    @check.url.should eq(url)
  end
  
  it "should have a name" do
    @check.name.should eq("The Best 1,000 Movies Ever Made top movies")
  end
  
  it "should cache #movies" do
    @check.instance_eval { @movie.should_receive(:new).exactly(1002).times }
    2.times { @check.movies }
  end
end