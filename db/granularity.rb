require 'date'

def granularity(startTime, stopTime)
  grain = (stopTime - startTime) / 20
  times = []
  while stopTime > startTime do
    times.push([startTime, startTime + grain - 0.0000000001])
    startTime += grain
  end
  return times
end

puts(granularity(DateTime.new(2014, 1, 1), DateTime.new(2015, 1, 1)))
