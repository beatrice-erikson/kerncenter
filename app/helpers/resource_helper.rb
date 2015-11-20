module ResourceHelper
	def line_chart(resource, resource_usage, resource_generation, hours)
		chart = LazyHighCharts::HighChart.new("graph") do |g|
			g.title(text: resource.capitalize + " Over Time")
			g.xAxis(categories: hours)
			g.series(name: resource.capitalize + " Usage", data: resource_usage)
			g.series(name: resource.capitalize + " Generation", data: resource_generation)
		end
		high_chart(resource + "_chart", chart)
	end
	def bar_chart(resource, resource_usage, resource_generation, hours)
		@graph = LazyHighCharts::HighChart.new('column') do |b|
			b.series(:name => resource.capitalize  + " Usage", :data=> resource_usage)
			b.series(:name => resource.capitalize + " Generation",:data=> resource_generation)       
			b.title({ :text => resource.capitalize + " Over Time"})
			b.legend({:align => 'left', 
				:x => -100, 
				:verticalAlign => 'top',
				:y => 20,
				:floating => "false",
				:backgroundColor => '#DDDDDD',
				:borderColor => '#BBB',
				:borderWidth => 0.25,
				:shadow => "false"})
			b.options[:chart][:defaultSeriesType] = "column"
			b.options[:xAxis] = {:plot_bands => "none", :title => {:text => "Time"}, :categories => hours}
			b.options[:yAxis][:title] = {:text => "Consumption"}
			b.plotOptions(series:{
				:cursor => 'pointer', 
				:point => {:events => {:click => "click_function"}}})
		end
		high_chart(resource + "_graph", @graph) do |w|
			raw "options.plotOptions.series.point.events.click = function() { location.href = 'http://duckduckgo.com'}"
		end
    end
end
