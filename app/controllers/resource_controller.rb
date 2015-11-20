class ResourceController < ApplicationController
  def show
	@resource = params[:resource]
	@sensors = Type.find_by_resource(@resource).sensors
	hours = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
	resource_usage = [45.0, 34.6, 77.4, 12.0, 55.4, 33.4, 48.8, 64.3, 12.3, 32.1]
	resource_generation = [90.7, 129.5, 45.4, 44.8, 102.5, 66.7, 93.7, 77.8, 88.9, 99.9]
	@resource_vars = [@resource, resource_usage, resource_generation, hours]
  end
end
