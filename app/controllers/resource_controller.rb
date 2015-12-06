class ResourceController < ApplicationController
  def show
<<<<<<< Updated upstream
	@resource = params[:resource]
	@sensors = Type.find_by_resource(@resource).sensors
  @subtypes = Type.find_by_resource(@resource).subtypes
	@hours = @sensors.first.times
	@resource_usage = @sensors.first.amounts(params[:start], params[:stop])
	@resource_generation = @sensors.second.amounts(params[:start], params[:stop])
	@resource_vars = [@resource, @subtypes, @resource_usage, @resource_generation, @hours]
=======
	@resource = Type.includes(:subtypes => :sensors).find_by_resource(params[:resource])
	@usage_types = @resource.subtypes.where(usage?: true)
	@gen_types = @resource.subtypes.where(usage?: false)
	@usage = @usage_types.map {|u| u.sensors.map {|s| s.amounts(params[:start], params[:stop]).sum}.sum}
	@gen = @gen_types.map {|g| g.sensors.map {|s| s.amounts(params[:start], params[:stop]).sum}.sum}
	hours = [1,2,3,4,5,6]
	
>>>>>>> Stashed changes
  end
end
