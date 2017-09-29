class ResourceController < ApplicationController
  include ChartHelper
  include ApplicationHelper
  def electricity
    @rname = 'electricity'
    display
  end
  def water
    @rname = 'water'
    display
  end
  def display
    @resource = Type.find_by_resource(@rname)
    if params[:chart] == 'subtype'
      @chartvars = ['column'].concat(stackedSubtypeChart(:day))
    elsif params[:chart] == 'program'
      @chartvars = ['area'].concat(stackedProgramChart(:day))
    end
    respond_to do |format|
      format.html
      format.csv {send_data to_csv(@chartvars[1])}
    end
  end
end
