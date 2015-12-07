module ApplicationHelper
	require 'date'
  require 'active_support'
  require 'active_support/core_ext/date_time'
  def granularity(startTime, stopTime)
		grain = (stopTime - startTime) / 5
		times = []
		while stopTime > startTime do
			times.push([startTime.beginning_of_day(), startTime.end_of_day()])
			startTime += grain
		end
		return times
  end
end