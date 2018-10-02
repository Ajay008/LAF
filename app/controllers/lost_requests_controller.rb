class LostRequestsController < ApplicationController

  def new
    if(!session[:user_id])
      redirect_to :controller => "users", :action => "login"      
    else
      @user = User.find(session[:user_id])
    end
    @lost_request = LostRequest.new
  end

  def place_request

    if(session[:user_id])
      @user = User.find(session[:user_id])
    end

    @lost_request = LostRequest.new
    @lost_request.item_type = params[:lost_request][:item_type]
    @lost_request.color = params[:lost_request][:color]
    @lost_request.brand = params[:lost_request][:brand]
    @lost_request.status = params[:lost_request][:status]
    @lost_request.user_id = params[:lost_request][:user_id]
    @lost_request.found_code = params[:lost_request][:found_code]
    
    @lost_request.date = Date.parse(params[:lost_request]["date(3i)"] + "-" + params[:lost_request]["date(2i)"] +"-" + params[:lost_request]["date(1i)"])
    


    if @lost_request.save
      flash[:msg] = "Lost request submitted"
    else
      render "new"
      return
    end

    redirect_to :controller => 'lost_requests', :action => 'new'
  end

end
