class ResourceController < ApplicationController
  def show
	@resource = params[:resource]
	
    	# dummy code below for a line graph
    	hours = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    	resource_usage = [45.0, 34.6, 77.4, 12.0, 55.4, 33.4, 48.8, 64.3, 12.3, 32.1]
    	resource_generation = [90.7, 129.5, 45.4, 44.8, 102.5, 66.7, 93.7, 77.8, 88.9, 99.9]
    	@chart = LazyHighCharts::HighChart.new("graph") do |g|
      		g.title(text: @resource + " Over Time")
      		g.xAxis(categories: hours)
      		g.series(name: @resource + " Usage", data: resource_usage)
      		g.series(name: @resource + " Generation", data: resource_generation)
    	end
    	# dummy code for a bar graph
    	@graph = LazyHighCharts::HighChart.new('column') do |b|
    		b.series(:name => @resource  + " Usage",:data=> [45.0, 34.6, 77.4, 12.0, 55.4, 33.4, 48.8, 64.3, 12.3, 32.1])
    		b.series(:name => @resource + " Generation",:data=> [90.7, 129.5, 45.4, 44.8, 102.5, 66.7, 93.7, 77.8, 88.9, 99.9])       
    		b.title({ :text => @resource + " Over Time"})
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
