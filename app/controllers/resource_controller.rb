class ResourceController < ApplicationController
  def show
	@resource = params[:resource]
	@sensors = Type.find_by_resource(@resource).sensors
	hours = @sensors.first.times
	resource_usage = @sensors.first.amounts(DateTime.new(2015,11,30), DateTime.new(2015,12,1))
	resource_generation = @sensors.second.amounts(DateTime.new(2015,11,30), DateTime.new(2015,12,1))
	@resource_vars = [@resource, resource_usage, resource_generation, hours]
  end
end
