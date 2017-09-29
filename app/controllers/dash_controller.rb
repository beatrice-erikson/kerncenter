class DashController < ApplicationController
  include ChartHelper
  def index
    @data = gaugeChart
  end
end
