# ICheckMovies

Get easy access to any public [ICheckMovies](http://www.icheckmovies.com/) [list](http://www.icheckmovies.com/list/the+best+1000+movies+ever+made/).

## How to use

### Find by url

``` ruby
require "icheckmovies"
result = ICheckMovies.fetch("http://www.icheckmovies.com/list/the+best+1000+movies+ever+made/")

result.movies.count # => 1002
result.movies.first.title # => À nous la liberté
```

## Data to work with

### Accessors
 
- **name** (String) List name.
- **url** (String) Full URL to the given list.
- **movies** (Array< Movie >) A list of movies.

### A movie object

The `movies` method returns a list of movies.
 
- **id** (String) IMDb movie id.
- **imdb_link** (String) IMDb link.
- **title** (String) Movie title.
- **year** (Fixnum) Release year.
- **details** (String) Url to ICheckMovies detail page.
 
## How do install

    [sudo] gem install icheckmovies

## Requirements

*ICheckMovies* is tested in OS X 10.7.1 using Ruby 1.9.2.

## License

*ICheckMovies* is released under the MIT license.