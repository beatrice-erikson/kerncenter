class ResourceController < ApplicationController
  def show
	@resource = params[:resource]
	
    	# dummy code below for a line graph
    	hours = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    	black_water = [45.0, 34.6, 77.4, 12.0, 55.4, 33.4, 48.8, 64.3, 12.3, 32.1]
    	grey_water = [90.7, 129.5, 45.4, 44.8, 102.5, 66.7, 93.7, 77.8, 88.9, 99.9]
    	@chart = LazyHighCharts::HighChart.new("graph") do |g|
      		g.title(text: "Water Usage")
      		g.xAxis(categories: hours)
      		g.series(name: "black", data: black_water)
      		g.series(name: "grey", data: grey_water)
    	end
    	# dummy code for a bar graph
    	@graph = LazyHighCharts::HighChart.new('column') do |b|
    		b.series(:name=>'black',:data=> [45.0, 34.6, 77.4, 12.0, 55.4, 33.4, 48.8, 64.3, 12.3, 32.1])
    		b.series(:name=>'grey',:data=> [90.7, 129.5, 45.4, 44.8, 102.5, 66.7, 93.7, 77.8, 88.9, 99.9])       
    		b.title({ :text=>"Water Consumption"})
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
        	b.options[:xAxis] = {:plot_bands => "none", :title => {:text => "Time"}, :categories => [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]}
        	b.options[:yAxis][:title] = {:text => "Consumption"}
        	b.plotOptions(series:{
        		:cursor => 'pointer', 
        		:point => {:events => {:click => "click_function"}}})
      end
  end
end
