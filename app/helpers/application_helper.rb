module ApplicationHelper
	require 'date'
	def granularity(startTime, stopTime)
		grain = (stopTime - startTime) / 5
		times = []
		while stopTime > startTime do
			times.push([startTime, startTime + grain - 0.0000000001])
			startTime += grain
		end
		return times
	end
end
