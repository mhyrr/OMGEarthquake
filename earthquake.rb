
#!/usr/bin/ruby

require 'curb'
require 'date'
require 'time'

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

c = Curl::Easy.new("http://earthquake.usgs.gov/earthquakes/catalogs/eqs1hour-M0.txt")

while(1) do

	c.perform
	puts c.body_str

	arr = c.body_str.split("\n")[1].split(",")

	utc = (arr[3] + arr[4] + arr[5]).gsub("\"", "")

	puts utc

	date = DateTime.strptime(utc, "%A %B %d %Y %H:%M:%S %Z").to_local_time

	now = Time.now

	#puts date.to_s
	#puts now.strftime("%A %B %d %Y %H:%M:%S %Z")

	puts now - date

	if (now - date < 60)
		puts "###############################\n#\nwow! earthquake within the last minute!\n#\n################################"
	end

	sleep 60

end