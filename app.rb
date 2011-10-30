require 'bundler/setup'
require 'sinatra'
require 'mongo_mapper'
require 'mustache/sinatra'


MongoMapper.database = 'omgearthquake'

class Earthquake
  include MongoMapper::Document

  key :id, String
  key :time, String
  key :lat, Float
  key :long, Float
  key :magnitude, Float
  key :region, String

  timestamps!
end

class App < Sinatra::Base
  get '/' do
    'hello world'
  end
end
