module ApplicationHelper
	require 'date'
  require 'active_support'
  require 'active_support/core_ext/date_time'
  def granularity(startTime, stopTime)
    raise "Start time must be before end time" if startTime >= stopTime
    interval = 7
    if (stopTime - startTime) >= 30
      interval = 10
    end
    if (stopTime - startTime) >= 364
      interval = 12
    end
    remainder = (stopTime - startTime) % interval
    firstTime = remainder / 2
    lastTime = remainder - firstTime
		grain = (stopTime - startTime - lastTime) / interval
		times = []
    if firstTime > 0
      times.push([startTime.beginning_of_day, startTime.end_of_day])
    end
    startTime += firstTime
		while startTime < (stopTime - lastTime) do
			times.push([startTime.beginning_of_day, startTime.end_of_day])
			startTime += grain
    end
    if (lastTime > 0)
      times.push([stopTime.beginning_of_day, stopTime.end_of_day])
    end
    times
  end
end

