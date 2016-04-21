module ChartHelper
  
  #this will be a cumulative graph plotting a variable number of series
  def improved_line_chart(resource, usage, generation, use_totals, gen_totals, hours)
    @chart = LazyHighCharts::HighChart.new("spline") do |p|
      p.title(text: resource.capitalize + " Over Time")
      p.xAxis(categories: hours)
	  p.plotOptions({:spline => {:marker => {:enabled => false}}})
      usage.each {|type, values| p.series(type: 'spline', name: type.capitalize, data: values)}
	  generation.each {|type, values| p.series(type: 'spline', name: type.capitalize, data: values)}
      p.series(type: 'spline', name: "Cumulative Usage", data: use_totals)
	  p.series(type: 'spline', name: "Cumulative Generation", data: gen_totals)
      p.legend(:layout => 'horizontal', :style => {
        :left => 'auto',
        :bottom => 'auto',
        :right => '50px',
        :top => '100px'
      })
    end
    high_chart(resource + "_chart", @chart)
  end
  

  # this will be a cumulative graph reflecting the entire progress of the building energy consumption, generation, and the net result of the former two
  def overview_chart(resource, usage, generation, use_totals, gen_totals, hours)
    @chart = LazyHighCharts::HighChart.new("spline") do |i|
      i.chart({
        :type => 'areaspline',
        :margin => [30, 5, 5, 30],
        :zoomType => 'x'
      })
      i.legend(:layout => 'horizontal', :style => {
        :left => 'auto',
        :bottom => 'auto',
        :right => '50px',
        :top => '100px'
      })
      i.plotOptions({spline:{marker:{enabled: true}}})
			i.series(name: "Cumulative Consumption: " + resource, data: use_totals)
			i.series(name: "Cumulative Generation: " + resource, data: gen_totals)
      i.series(name: "Net " + resource, data: gen_totals - use_totals)
      i.subtitle(text: "Select plot area to zoom in.")
      i.title(text: "Living Building Progress")
      i.xAxis({
        dateTimeLabelFormats: {
          month: '%e. %b',
          year: '%b'
        },
        type: 'datetime',
        title: {
          text: "Date"
        }
      })
      i.yAxis({
        plotOptions: {
          spline: {
            marker: {
              enabled: true
            }
          }
        },
        title: {
          text: "Energy Units (  )"
        },
        tooltip: {
          headerFormat: '{series.name}<br>',
          pointFormat: '{point.x.:%e. %b}: {point.y:.2f} m'
        }
      })
        
    end
    high_chart("irregular_intervals_zoomable" + resource + "_chart", @chart)
  end
  
  #this will be a pie chart giving an overview of usage from the nearest midnight to current time
  def pie_chart(resource, usage, generation, use_totals, gen_totals, hours)
		@chart = LazyHighCharts::HighChart.new("pie") do |f|
      f.chart({
        :type => "pie",
        :margin => [30, 5, 5, 5]
      })
      f.title(text: "Relative " + resource.capitalize + " Usage")
      f.legend(:layout => 'horizontal')
	  usedata = usage.map {|t, v| [t.capitalize, v.sum]}
	  series = {
				:type=> 'pie',
				:name=> resource.capitalize + ' Chart',
				:data=> usedata,
				:innerSize=> 200}
	  f.series(series)
      f.plot_options(:pie =>{
        :allowPointSelect => true, 
        :cursor => "pointer", 
        :dataLabels =>{
          :enabled => true,
          :color => "black",
          :format => '<b>{point.name}</b>: {point.percentage:.1f} %'
        }
      })
    end
    high_chart("today_" + resource + "_chart", @chart)
  end
end