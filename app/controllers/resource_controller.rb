class ResourceController < ApplicationController
  def show
	@resource = Type.includes(:subtypes => :sensors).find_by_resource(params[:resource])
	@usage_types = @resource.subtypes.where(usage?: true)
	@gen_types = @resource.subtypes.where(usage?: false)
	@usage = @usage_types.map {|u| u.sensors.map {|s| s.amounts(params[:start], params[:stop]).sum}.sum}
	@gen = @gen_types.map {|g| g.sensors.map {|s| s.amounts(params[:start], params[:stop]).sum}.sum}
	hours = [1,2,3,4,5,6]
  end
end
