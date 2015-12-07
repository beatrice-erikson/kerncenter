class ResourceController < ApplicationController
  include ApplicationHelper
  def show
	@resource = Type.includes(:subtypes => :sensors).find_by_resource(params[:resource])
	@usage_types = @resource.subtypes.where(usage?: true)
	@usage_type_names = @usage_types.pluck(:name)
	@gen_types = @resource.subtypes.where(usage?: false)
	@gen_type_names = @gen_types.pluck(:name)
	@usage = @usage_types.map {|u| u.sensors.map {|s| s.amounts(params[:start], params[:stop]).sum}.sum}
	@gen = @gen_types.map {|g| g.sensors.map {|s| s.amounts(params[:start], params[:stop]).sum}.sum}
	@hours = granularity(DateTime.parse(params[:start]), DateTime.parse(params[:stop]))
	@hour_names = @hours.map { |h| h[0].to_date }
	@usage_time_values = Array.new
	@gen_time_values = Array.new
	for timepair in @hours
		@usage_time_values << @usage_types.map {|u| u.sensors.map {|s| s.amounts(timepair[0], timepair[1]).sum}.sum}
		@gen_time_values << @gen_types.map {|g| g.sensors.map {|s| s.amounts(timepair[0], timepair[1]).sum}.sum}
	end
	@usage_time_values = @usage_time_values.transpose
	@usage_time_values = @usage_type_names.zip(@usage_time_values)
	@usage_time_values = Hash[@usage_time_values.map {|key, value| [key, value]}]
	@gen_time_values = @gen_time_values.transpose
	@gen_time_values = @gen_type_names.zip(@gen_time_values)
	@gen_time_values = Hash[@gen_time_values.map {|key, value| [key, value]}]
	@resource_vars = [@resource.resource, @usage_time_values, @gen_time_values, @hour_names]
  end
end
