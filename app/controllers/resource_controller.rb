class ResourceController < ApplicationController
  def show
	@resource = params[:resource]
  end
end
