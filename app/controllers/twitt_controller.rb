class TwittController < ApplicationController
gem('twitter4r', '>=0.2.0')
require 'twitter'
require 'twitter_search'
require 'twitter/console'
require 'rubygems'
require 'google_geocode'
include Geokit::Geocoders
include Geokit
before_filter :authorize, :except => [:login, :authenticate, :save_users, :twitter_cred]


def login
   @user = User.new
end

def twitter_cred
   client=Twitter::Client.new(:login =>session[:user] , :password => session[:pwd])
   return client
end

def authenticate
   @user = User.new(params[:user])
   client = Twitter::Client.new
    if client.authenticate?(@user.username, @user.password)
       @username = User.save_users(params[:user])
   session[:user_id] = @user.id
   session[:username] = @user.username
   session[:password] = @user.password
       redirect_to :action =>'post_status'
    else
       render :action =>'login'
    end
end

def post_status
    @post = Post.new(params[:post])
    #@user = User.find(params[:id])
    twitter = Twitter::Client.new(:login => session[:username], :password => session[:password])
    status = twitter.status(:post, @post.message)
end

def logout   
   #session[:user] = nil
   session[:user_id] = nil
   session[:username] = nil
   session[:password] = nil
    if reset_session
       redirect_to :action =>'login'
    else
       render :action =>'post_status'
    end
end

def timeline
   client = Twitter::Client.new
   @timeline = client.timeline_for(:public)
end

def search
   @client = TwitterSearch::Client.new 'user agent'
   @tweets = @client.query :q => 'twitter search'
   puts @tweets
   #@tweets = @client.query :q => 'hyderabad', :rpp => '10'
   #@search = Twitter::Search.new(twitter search).each { |r| puts r.inspect }
end

#########################

def keyword
   @keyword = Keyword.new
end

def find
   @keyword = Keyword.new(params[:keyword])
   @search = Twitter::Search.new(@keyword).each { |r| puts r.inspect }
end

###########################

def rmap
   @res = Geokit::Geocoders::GoogleGeocoder.reverse_geocode "17.3986695, 78.4325615"
   puts @res
end

def rgeo
end

def map   
   @location = Location.new(params[:location])   
   @address = @location.address
#puts "I am in Map"
#puts @address
   if @address == nil
     coordinates = GoogleGeocoder.geocode("parklane,secunderabad,ap,india")
   else
     coordinates = GoogleGeocoder.geocode(@address)
   end
#puts "I am in Map ends"
   @map = GMap.new("map")
   @map.control_init(:large_map => true,:map_type => false)
   @map.center_zoom_init([coordinates.lat, coordinates.lng], 13)
   puts coordinates.lat
   puts coordinates.lng

end  


end
