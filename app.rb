require 'bundler/setup'
require 'sinatra'
require 'mongo_mapper'
require 'mustache/sinatra'
require 'earthquake'

MongoMapper.database = 'omgearthquake'

get '/' do

	quakes = Earthquake.all
	quakes.map {|eq| eq.eqid }.inspect

end
