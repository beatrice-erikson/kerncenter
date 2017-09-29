module ChartHelper
  def offset(datestring, offset, grouping)
    datestring.to_date
      .advance(grouping.to_s.pluralize.to_sym => offset)
  end
  def formatChartData(sourceData)
    agg = {}
    sourceData.map do |(date, groupName, altGroupName), value|
      agg[[groupName, altGroupName]] ||= { name: groupName, data: {} }
      agg[[groupName, altGroupName]][:data][date] = value
    end
    groupedData = {}
    for gn in agg.map {|(groupName, _), _| groupName}.uniq
      vals = agg.select {|k,_| k[0] == gn}.values
      groupedData[gn] = vals.pop
      until vals.empty?
        groupedData[gn][:data].merge!(vals.pop[:data]){|k, oldv, newv| oldv + newv}
      end
      groupedData[gn][:data] = groupedData[gn][:data].to_a
    end
    groupedData = groupedData.values
    groupedData.each_with_index do |group, gi|
      group[:data].to_enum.with_index.reverse_each do |v, i|
        if i > 0
          groupedData[gi][:data][i][1] -= groupedData[gi][:data][i-1][1]
        end
      end
      groupedData[gi][:data].shift
    end
  end
  def stackedSubtypeChart(grouping)
    rsubs = Measurement
              .where("measurements.date >= ? AND measurements.date <= ?",
                  offset(params[:start], -1, grouping),
                  offset(params[:stop], 1, grouping))
              .joins(sensor: {subtype: :type})
              .where("types.resource = ?", @rname)
              .order("subtypes.usage")
              .group_by_period(grouping, :date, series: false).group("subtypes.id, subtypes.name").group("sensors.id").maximum(:amount)
    rsubs = formatChartData(rsubs)
    gencount = @resource.subtypes.where(usage: false).count
    lines = {}
    for i in 0...gencount
      lines[i] = {type: "line"}
    end
    [rsubs, lines]
  end
  def stackedProgramChart(grouping)
    rprogs = Measurement
              .where("measurements.date >= ? AND measurements.date <= ?",
                offset(params[:start], -1, grouping),
                offset(params[:stop], 1, grouping))
              .joins(sensor: [:program, subtype: [:type]])
              .where("types.resource = ?", @rname)
              .order("subtypes.usage")
              .group_by_period(grouping, :date).group("subtypes.id, programs.id, programs.name").group("sensors.id").maximum(:amount)
    rprogs = formatChartData(rprogs)
    area_chart rprogs, stacked: true
  end
  def gaugeChart
    data = Measurement
                .where("measurements.date <= ? AND measurements.date >= ?",
                 "2017-06-29 00:00:00 UTC",
                 "2017-06-28 23:45:00 UTC")
                .joins(sensor: {subtype: :type})
                .where("subtypes.usage = ?", true)
                .group("subtypes.name").sum(:amount).to_a
  end
end