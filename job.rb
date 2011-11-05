require 'curb'
require 'date'
require 'time'
require 'earthquake'
require 'mongo_mapper'

## From O'Reilly's Ruby Cookbook
class Date
  def to_gm_time
    to_time(new_offset, :gm)
  end

  def to_local_time
    to_time(new_offset(DateTime.now.offset-offset), :local)
  end

  private
  def to_time(dest, method)
    #Convert a fraction of a day to a number of microseconds
    usec = (dest.sec_fraction * 60 * 60 * 24 * (10**6)).to_i
    Time.send(method, dest.year, dest.month, dest.day, dest.hour, dest.min,
              dest.sec, usec)
  end
end

def twitterize(eq)
	puts "to the cloud"
end

job 'usgs.curl' do

	MongoMapper.database = 'omgearthquake'

	c = Curl::Easy.new("http://earthquake.usgs.gov/earthquakes/catalogs/eqs1hour-M0.txt")
	c.perform
	puts "Raw Curl:\n#{c.body_str}"

	c.body_str.split("\n").select{ |l| !l.include?("Src")}.each do |line|

		arr = line.split(",")

		if Earthquake.all(:eqid => (arr[1])).empty?

			eq = Earthquake.new
			eq.eqid = arr[1]
			eq.time = (arr[3] + arr[4] + arr[5]).gsub("\"", "")
			eq.lat = arr[6]
			eq.long = arr[7]
			eq.digraph = arr[0]
			eq.region = arr[11]
			eq.magnitude = arr[8]

			puts "Saving new earthquake: #{eq.eqid}"

			eq.save

			twitterize(eq)

		end

	end

end
