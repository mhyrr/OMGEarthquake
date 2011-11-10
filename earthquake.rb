require 'mongo_mapper'

class Earthquake
  include MongoMapper::Document

  def to_twitter

  	usgs_link = "USGS link: http://earthquake.usgs.gov/earthquakes/recenteqsus/Quakes/#{digraph}#{eqid}.php"

	(magnitude >= 5 ? "Wow! " : "") << magnitude.to_s << " earthquake " << (region.match(/^off|^near|^south |^north |^east|^west /) ? "" : "in ") << region << " - " << usgs_link << "#earthquake #quake"

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