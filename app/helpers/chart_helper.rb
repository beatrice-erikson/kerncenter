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
    agg = {}
    rsubs.map do |(date, stype), value|
      agg[stype] ||= { name: stype, data: [] }
      agg[stype][:data].append([date,value])
    end
    rsubs = agg.values
    rsubs.each_with_index do |stype, si|
      stype[:data].to_enum.with_index.reverse_each do |v, i|
        if i > 0
          rsubs[si][:data][i][1] -= rsubs[si][:data][i-1][1]
        end
      end
      rsubs[si][:data].shift
    end
    gencount = @resource.subtypes.where(usage?: false).count
    lines = {}
    for i in 0...gencount
      lines[i] = {type: "line"}
    end
    return column_chart rsubs,
                        stacked: true,
                        library: { :series => lines }
  end
  def stackedProgramChart(resource)
    
  end
end