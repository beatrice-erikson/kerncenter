module ChartHelper
  def stackedSubtypeChart(grouping)
    rsubs = Subtype.includes(:type, sensors: :measurements)
            .where("types.resource = ?", @rname)
            .where("measurements.date >= ?", params[:start])
            .where("measurements.date <= ?", params[:stop])
            .references(:types).references(:measurements)
                .order(:usage?) #add usage types after gen types
                .map{|stype| [
                    stype.name,stype.measurements #this takes too long!
                    .group_by_period(grouping, :date).maximum(:amount)]}

    rsubs = rsubs.map {|stype|
                        {name: stype[0],
                        data: stype[1]}}
    
    return column_chart rsubs,
                        stacked: true,
                        library: { :series => {0 => { type: "line"}}}
  end
  def stackedProgramChart(resource)
    
  end
end