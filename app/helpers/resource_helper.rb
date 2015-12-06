module ResourceHelper
	def line_chart(resource, subtypes, resource_usage, resource_generation, hours)
		@chart = LazyHighCharts::HighChart.new("graph") do |g|
			g.title(text: resource.capitalize + " Over Time")
			g.xAxis(categories: hours)
			g.series(name: resource.capitalize + " Usage", data: resource_usage)
			g.series(name: resource.capitalize + " Generation", data: resource_generation)
		end
		high_chart(resource + "_chart", @chart)
	end
  
  #this will be a cumulative graph plotting a variable number of series
  def improved_line_chart(resource, subtypes, resource_usage, resource_generation, hours)
    @chart = LazyHighCharts::HighChart.new("graph") do |p|
      p.title(text: resource.capitalize + " Over Time")
      p.xAxis(categories: hours)
      subtypes.each do |type|
        p.series(name: type.name, data: resource_usage)
      end
      #p.series(series)
      p.legend(:layout => 'horizontal', :style => {
        :left => 'auto',
        :bottom => 'auto',
        :right => '50px',
        :top => '100px'
      })
    end
    high_chart(resource + "_chart", @chart)
  end
  
  #this will be a pie chart giving an overview of usage from the nearest midnight to current time
  def pie_chart(resource, subtypes, resource_usage, resource_generation, hours)
		@chart = LazyHighCharts::HighChart.new("pie") do |f|
      f.chart({
        :type => "pie",
        :margin => [30, 5, 5, 5]
      })
      f.title(text: "Today's " + resource.capitalize + " Usage")
      f.legend(:layout => 'horizontal')
      subtypes.each do |type|
        f.series(name: type.name, data: resource_usage, innerSize: 200)
      end
      f.plot_options(:pie =>{
        :allowPointSelect => true, 
        :cursor => "pointer", 
        :dataLabels =>{
          :enabled => false,
          :color => "black",
          #:format => '<b>{point.name}</b>: {point.percentage:.} %'
        }
      })
    end
    high_chart("today_" + resource + "_chart", @chart)
  end
end
