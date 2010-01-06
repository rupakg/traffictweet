class SearchController < ApplicationController
require 'twitter'
require 'rubygems'
  
def keyword
   @keyword = Keyword.new
end

def find
   @keyword = Keyword.new(params[:keyword])
   @search = Twitter::Search.new(@keyword).each { |r| puts r.inspect }
end


end
