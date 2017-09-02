module ChartHelper
  def pluralize(symbol)
    return symbol.to_s.pluralize.to_sym
  end
  def stackedSubtypeChart(grouping)
    rsubs = Measurement
              .where("measurements.date >= ? AND measurements.date <= ?",
                  params[:start].to_date.advance(pluralize(grouping) => -1),
                  params[:stop].to_date.advance(pluralize(grouping) => 1))
              .joins(sensor: {subtype: :type})
              .where("types.resource = ?", @rname)
              .order('subtypes."usage?"')
              .group_by_period(grouping, :date).group("subtypes.id, subtypes.name").maximum(:amount)
    rsubs = rsubs.group_by do |(_, subname),_|
              subname #group by subtype name
            end
    rsubs.each do |k,v|
      rsubs[k] = v.map{|date| [date[0][0],date[1]]} #format as [[date, measurement],...]
      v.reverse.each_index do |i|
        if i > 0
          rsubs[k][i][1] = v[i][1]-v[i-1][1]
        end
      end
      rsubs[k].shift
    end

    rsubs.map{|stype,data| {name: stype, data: data}}

    return  column_chart rsubs,
                        stacked: true,
                        library: { :series => {0 => { type: "line"}}}
  end
  def stackedProgramChart(resource)
    
  end
end