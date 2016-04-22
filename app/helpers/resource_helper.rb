module ResourceHelper
  include ChartHelper
  def getResourceVars (resource)
		@resource = Type.includes(:subtypes => :sensors).find_by_resource(resource)
		@usage_types = @resource.subtypes.where(usage?: true)
		@usage_type_names = @usage_types.pluck(:name)
		@gen_types = @resource.subtypes.where(usage?: false)
		@gen_type_names = @gen_types.pluck(:name)
		@usage = @usage_types.map {|u| u.sensors.map {|s| s.amounts(params[:start], params[:stop]).sum}.sum}
		@gen = @gen_types.map {|g| g.sensors.map {|s| s.amounts(params[:start], params[:stop]).sum}.sum}
		@days = granularity(params[:start].to_date, params[:stop].to_date)
		@day_names = @days.map { |d| d[0].to_formatted_s(:short)[0..5] }
		@usage_day_values = Array.new
		@gen_day_values = Array.new
		for daypair in @days
			@usage_day_values << @usage_types.map {|u| u.sensors.map {|s| s.amounts(daypair[0], daypair[1]).sum}.sum}
			@gen_day_values << @gen_types.map {|g| g.sensors.map {|s| s.amounts(daypair[0], daypair[1]).sum}.sum}
		end
		@usage_day_values = @usage_day_values.transpose
		for i in 0 ... @usage_day_values.size
			for j in 1 ... @usage_day_values[i].size
				@usage_day_values[i][j] += @usage_day_values[i][j-1]
			end
		end
		@usage_cuml = @usage_day_values.transpose.map {|x| x.reduce(:+)}
		@usage_day_values = @usage_type_names.zip(@usage_day_values)
		@usage_day_values = Hash[@usage_day_values.map {|key, value| [key, value]}]
		@gen_day_values = @gen_day_values.transpose
		for i in 0 ... @gen_day_values.size
			for j in 1 ... @gen_day_values[i].size
				@gen_day_values[i][j] += @gen_day_values[i][j-1]
			end
		end
		@gen_cuml = @gen_day_values.transpose.map {|x| x.reduce(:+)}
		@gen_day_values = @gen_type_names.zip(@gen_day_values)
		@gen_day_values = Hash[@gen_day_values.map {|key, value| [key, value]}]
		@resource_vars = [@resource.resource, @usage_day_values, @gen_day_values, @usage_cuml, @gen_cuml, @day_names]
	end
end
