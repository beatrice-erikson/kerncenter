class ProgramController < ApplicationController
  def index
  end

  def show
	@sensors = Program.find_by_name(params[:program]).sensors
	
  end
end
