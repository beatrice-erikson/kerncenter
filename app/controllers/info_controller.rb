class InfoController < ApplicationController
  def show
	@page = "page_" + params[:page].to_s
	@pagenum = params[:page].to_i
	@prevpage = "page_" + (@pagenum - 1).to_s
	@nextpage = "page_" + (@pagenum + 1).to_s
  end
end
