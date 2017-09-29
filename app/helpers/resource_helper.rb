module ResourceHelper
  def chart(c_type, data, lines)
    case c_type
      when 'column' then column_chart data, stacked: true, library: { :series => lines }
      when 'area' then area_chart data, stacked: true
      else "undefined"
    end
  end
end
