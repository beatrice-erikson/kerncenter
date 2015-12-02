class ResourceController < ApplicationController
  def show
	@resource = params[:resource]
	@sensors = Type.find_by_resource(@resource).sensors
  @subtypes = Type.find_by_resource(@resource).subtypes
	@hours = @sensors.first.times
	@resource_usage = @sensors.first.amounts(params[:start], params[:stop])
	@resource_generation = @sensors.second.amounts(params[:start], params[:stop])
	@resource_vars = [@resource, @subtypes, @resource_usage, @resource_generation, @hours]
  end
end
