module ResourceHelper
  include ChartHelper
  def getResourceVars (resource)
		@resource = Type.includes(:subtypes => :sensors).find_by_resource(resource)
		@rsubs = @resource.subtypes.where(usage?: false).map{|stype| [stype.name, stype.measurements.where("date >= ?", params[:start]).where("date <= ?", params[:stop])] }
		@rsubs = @rsubs.push(*@resource.subtypes.where(usage?: true).map{|stype| [stype.name, stype.measurements.where("date >= ?", params[:start]).where("date <= ?", params[:stop])] })
		
	end
end
