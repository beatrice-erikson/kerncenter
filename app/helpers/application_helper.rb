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

	def to_csv(data)
		CSV.generate do |csv|
			attributes = %w{name data}
			csv << attributes
			data.each do |group|
				csv << [group[:name]]
				csv << group[:data]
			end
		end
	end

	def ForTheGraph(theWholeThing)
		# theWholeThing is what is called @rsubs in the resource_charts view.
		# It looks like an array of arrays of arrays, 
		# where the innermost arrays have the name of the resource subtype as the first element
		# and the records of that type as the second element. 
		# That's probably not really what it is, but it looks like that when printed.
		# With only solar readings in the database, it looks like this:
		#  [["solar", #<ActiveRecord::AssociationRelation [#<Measurement id: 1, sensor_id: 17, date: "2017-06-14 16:00:41", amount: 134276.1>, #<Measurement id: 2, sensor_id: 17, date: "2017-06-14 16:01:45", amount: 134276.1>, ... ], ["mechanical", #<ActiveRecord::AssociationRelation []>], ["plug", #<ActiveRecord::AssociationRelation []>], ["lights", #<ActiveRecord::AssociationRelation []>]] 
		arrayOfHashesOfHashes = []
		theWholeThing.each do |aPiece|
			arrayOfHashesOfHashes <<  {name: aPiece[0], data: aPiece[1].group_by_day(:date).maximum(:amount)}
		end
		# array of hashes of hashes has one hash per resource
		# where the name symbol maps to the name of the subtype,
		# and the data symbol maps to a hash that maps dates to maximums for that day.
		# With only solar measurements in the database, it looks like this:
		#  [{:name=>"solar", :data=>{Wed, 14 Jun 2017=>134394.76, Thu, 15 Jun 2017=>135151.2, ... }}, {:name=>"mechanical", :data=>{}}, {:name=>"plug", :data=>{}}, {:name=>"lights", :data=>{}}]  
		arrayOfHashes = []
		arrayOfHashesOfHashes.each do |oneThing|
			arrayOfHashes << oneThing[:data]
		end
		# arrayOfHashes has one hash per resource, mapping dates to maximum values.
		# with only solar readings, it looks like this:
		#  [{Wed, 14 Jun 2017=>134394.76, Thu, 15 Jun 2017=>135151.2, ... }, {}, {}, {}] 
		#  since each of those elements is a hash, we can do
		#  arrayOfHashes[i].values() to get the maximum values for each that
		#  for a specific resource.
		#  Each of those arrays would look like this.
		#  [134394.76, 135151.2, ... ]
		#  so now we can substract A[i-1] from A[i] to compute
		#  how much was metered during day i.
		#  for i = 0, we need to set it to zero after A[1] has been processed. 
		#
		#  I'm not sure if the processing can be done by unpacking the data, processing stuff,
		#  and then repackaging, or if it has to be done directly in what the map generates
		#  with nested loops.
		arrayPositionsProcessedAlready = 0
		# some nested loops here.
		#
		# these are below so I can return them to the resource_charts view 
		# and see what type of thing they are by looking at the web browser.
		theWholeThing
		arrayOfHashesOfHashes
		arrayOfHashes
		arrayOfHashes[0].values()
	end
end

