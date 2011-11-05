require 'mongo_mapper'

class Earthquake
  include MongoMapper::Document

  key :eqid, String, :required => true
  key :time, String
  key :lat, Float
  key :long, Float
  key :magnitude, Float
  key :region, String
  key :digraph, String

  timestamps!
end