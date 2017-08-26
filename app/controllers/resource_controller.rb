class ResourceController < ApplicationController
  include ApplicationHelper
  def electricity
    @rname = 'electricity'
    @resource = Type.find_by_resource(@rname)
  end
  def water
    @rname = 'water'
    @resource = Type.find_by_resource(@rname)
  end
end
