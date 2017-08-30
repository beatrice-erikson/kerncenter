module ChartHelper
  def stackedSubtypeChart(grouping)
    rsubs = Measurement
                .where("measurements.date >= ?", params[:start])
                .where("measurements.date <= ?", params[:stop])
                .joins(sensor: {subtype: :type})
                .where('types.resource = ?', @rname)
                .group('subtypes."usage?", measurements.id')
                #.select("types.id, subtypes.name, max(amount)").map(&:attributes)
                #.select("types.resource")
                #.where("types.resource = ?", @rname)
                #.select("measurements.amount").map(&:attributes)
#    rsubs = Measurement.find_by_sql(
 #             'SELECT
  #              t.resource,
   #             st.name,
    #            st."usage?",
     #           m.date,
      #          m.amount
       #       FROM Types t
        #      INNER JOIN Subtypes st ON t.id = st.type_id
         #     INNER JOIN Sensors sn ON st.id = sn.subtype_id
          #    INNER JOIN Measurements m ON sn.id = m.sensor_id')
           #   .where('m.date <= ?', params[:start])
            #  .where('m.date >= ?', params[:stop])
             # .group_by_period(grouping, :date)
    #rsubs = Measurement
     #       .where("measurements.date >= ?", params[:start].to_date().advance(grouping => -1))
      #      .where("measurements.date <= ?", params[:stop])
       #     .group_by_period(grouping, :date)
            #.joins(sensor: :subtype)
            #.merge(Subtype.order(:usage?))
                

    #rsubs = rsubs.map {|stype|
     #                   {name: stype[0],
      #                  data: stype[1]}}
    
    return  rsubs
                 #       stacked: true,
                  #      library: { :series => {0 => { type: "line"}}}
  end
  def stackedProgramChart(resource)
    
  end
end