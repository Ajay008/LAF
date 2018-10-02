class FoundItemsController < ApplicationController

  def new
    if(!session[:a_user_id])
      redirect_to :controller => "admins", :action => "login"
    else
      @admin = Admin.find(session[:a_user_id])
    end
    @found_item = FoundItem.new
  end

  def add_item
     if(!session[:a_user_id])
      redirect_to :controller => "admins", :action => "login"
    else
      @admin = Admin.find(session[:a_user_id])
    end
    @found_item = FoundItem.new
    @found_item.item_type = params[:found_item][:item_type]
    @found_item.color = params[:found_item][:color]
    @found_item.brand = params[:found_item][:brand]
    @found_item.storage_loc = params[:found_item][:storage_loc]
    @found_item.locker_id = params[:found_item][:locker_id]
    #@found_item.created_at = params[:found_item][:created_at]
    @found_item.status = params[:found_item][:status]
    
    if @found_item.save
      flash[:msg] = "Found Item details added."
    else
      render "new"
      return
    end


    # match_for_new_found_item
    @lost_requests = LostRequest.where("status='approved' and found_code='-1'")
    request_id = -1
    @lost_requests.each do |lost_request|
      if @found_item.item_type.downcase().strip() == lost_request.item_type.downcase().strip() && @found_item.color.downcase().strip() == lost_request.color.downcase().strip() && @found_item.brand.downcase().strip() == lost_request.brand.downcase().strip() 
        request_id=lost_request.id
        break if 1==1
      end
    end

    if(request_id != -1)
      @found_item.status = 0
      @found_item.save

      @request = LostRequest.find(request_id)
      @request.found_code = @found_item.id 
      @request.save      
      #put 
    end


    
    redirect_to :controller => 'found_items', :action => 'new'
  end

end
