class AdminsController < ApplicationController
  
  def login
    if(session[:a_user_id])
      redirect_to :controller => "admins", :action => "home"
    end
  end

  def logout
    reset_session
    redirect_to :controller => "users", :action => "index"
  end
  
  def home
    @admins = Admin.all

    if(!session[:a_user_id])
      begin 
        @admin = @admins.find(params[:user_id])
      rescue ActiveRecord::RecordNotFound
        redirect_to :controller => "admins", :action => "login"
        return
      end
      if(@admin.password == params[:password])
        reset_session
        session[:a_user_id] = @admin.user_id 
      else
        flash[:msg] = "Invalid password."
        redirect_to :controller => "admins", :action => "login"
      end
    else
      @admin = @admins.find(session[:a_user_id])
    end

    @pending_requests = LostRequest.where("status = 'pending'")
    
    @processed_requests = LostRequest.where("status != 'pending'")
    
  end
  

  def approve
    @request = LostRequest.find(params[:request_id])
    @request.status = 'approved'
    @request.save
    
    # match_for_approved_request
    @found_items = FoundItem.where("status='-1'")
    match_id = -1
    @found_items.each do |found_item|
      if found_item.item_type.downcase().strip() == @request.item_type.downcase().strip() && found_item.color.downcase().strip() == @request.color.downcase().strip() && found_item.brand.downcase().strip() == @request.brand.downcase().strip() 
        match_id=found_item.id
        break if 1==1
      end
    end
    
    if(match_id != -1)
      @found_item = FoundItem.find(match_id)
      @found_item.status = 0
      @found_item.save

      @request.found_code = @found_item.id 
      @request.save      
    end
    #put
    redirect_to :controller => 'admins', :action => 'home'
  end

  def reject
    @request = LostRequest.find(params[:request_id])
    @request.status = 'rejected'
    @request.save
    redirect_to :controller => 'admins', :action => 'home'
  end

  def show_match
    if(!session[:a_user_id])
      redirect_to :controller => "admins", :action => "home"
    else
      @admin = Admin.find(session[:a_user_id])
    end
    @to_notify = LostRequest.where("status = 'approved' and found_code!='-1'")
  end

  def notify
    @request = LostRequest.find(params[:request_id])
    @request.status = 'match_found'
    @request.save
    redirect_to :controller => 'admins', :action => 'show_match'
  end


  def return_item
    if(!session[:a_user_id])
      redirect_to :controller => "admins", :action => "home"
    else
      @admin = Admin.find(session[:a_user_id])
    end
    @requests = LostRequest.where("status='match_found'")
    @returned_items = FoundItem.where("status='1'")
  end

  def return_item2
    @found_item = FoundItem.find(params[:found_id])
    @found_item.status = '1'
    @found_item.save

    @request = LostRequest.find(params[:request_id])
    @request.status = 'closed'
    @request.save
    
    redirect_to :controller => 'admins', :action => 'return_item'
  end

  def added_items
    if(!session[:a_user_id])
      redirect_to :controller => "admins", :action => "home"
    else
      @admin = Admin.find(session[:a_user_id])
    end

    if(params[:search])
      search_string = (params[:search]).strip()
      @added_items = FoundItem.where("item_type like '%#{search_string}%' or color like '%#{search_string}%' or brand like '%#{search_string}%'")
    else
      @added_items = FoundItem.all
    end
    
  end

end
