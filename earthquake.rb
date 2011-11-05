require 'mongo_mapper'

class Earthquake
  include MongoMapper::Document

  def to_twitter
  	if magnitude > 5
		"Wow! #{magnitude} earthquake in #{region}!  USGS link: http://earthquake.usgs.gov/earthquakes/recenteqsus/Quakes/#{digraph}#{eqid}.php"
  	else
		"#{magnitude} earthquake in #{region}!  USGS link: http://earthquake.usgs.gov/earthquakes/recenteqsus/Quakes/#{digraph}#{eqid}.php"
	end
  end


  key :eqid, String, :required => true
  key :time, String
  key :lat, Float
  key :long, Float
  key :magnitude, Float
  key :region, String
  key :digraph, String

  timestamps!
end