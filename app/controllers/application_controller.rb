class ApplicationController < ActionController::Base
	def show
		redirect_to :action => 'new'
	end

 before_action :set_cache_headers
  
  private

  def set_cache_headers
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

end
