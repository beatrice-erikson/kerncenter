require 'uri'
module ApplicationHelper
	require 'date'
	require 'active_support'
	def makeLink(link, name, color) #Returns nav link, unless it links to current page
		unless (params[:controller] == link.split('/')[1])
			return link_to(content_tag(:div, name), link, class: 'circle '+color)
		else
			if (params[:action].in?(['water', 'electricity']) && link.split('/')[2] != params[:action])
				return link_to(content_tag(:div, name), link, class: 'circle '+color)
			else
				return content_tag(:div, content_tag(:div, name), class: 'current '+color)
			end
		end
	end
end
