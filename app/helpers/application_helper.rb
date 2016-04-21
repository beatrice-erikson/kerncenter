module ApplicationHelper
	require 'date'
	require 'active_support'
	require 'active_support/core_ext/date_time'
	def granularity(startDay, stopDay)
		raise "Start day must be before end day" if startDay >= stopDay
		interval = 7
		if (stopDay - startDay) >= 30
			interval = 10
		end
		if (stopDay - startDay) >= 364
			interval = 12
		end
		remainder = (stopDay - startDay) % interval
		firstDay = remainder / 2
		lastDay = remainder - firstDay
		grain = (stopDay - startDay - lastDay) / interval
		days = []
		if firstDay > 0
			days.push([startDay, startDay])
		end
		startDay += firstDay
		while startDay < (stopDay - lastDay) do
			days.push([startDay, startDay])
			startDay += grain
		end
		if (lastDay > 0)
			days.push([stopDay, stopDay])
		end
		days
	end
	def makeLink(link, name, color) #Returns nav link, unless it links to current page
		if !current_page?(link)
			return link_to(content_tag(:div, name), link, class: 'circle '+color)
		else
			return content_tag(:div, content_tag(:div, name), class: 'current '+color)
		end
	end
end
