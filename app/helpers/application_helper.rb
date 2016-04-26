require 'uri'
module ApplicationHelper
	require 'date'
	require 'active_support'
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
		remainderStart = startDay + (remainder / 2)
		remainderStop = stopDay + remainder - (remainder / 2)
		grain = (stopDay - startDay - remainder) / interval
		days = []
		if remainderStart > startDay
			days << [startDay, remainderStart]
		end
		day = remainderStart
		while day < remainderStop do
			days << [day, day+grain]
			day += grain
		end
		if remainderStop < stopDay
			days << [day, stopDay]
		end
		days
		#until it was fixed, this helper was the equivalent of putting a sweater in a microwave
	end
	def makeLink(link, name, color) #Returns nav link, unless it links to current page
		if !(params[:controller] == link.split('/')[1])
			return link_to(content_tag(:div, name), link, class: 'circle '+color)
		else
			return content_tag(:div, content_tag(:div, name), class: 'current '+color)
		end
	end
end
