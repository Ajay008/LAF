class UsersController < ApplicationController

    def index
    end

    def login
        if(session[:user_id])
            redirect_to :controller => "users", :action => "home"
        end
    end

    def logout
        reset_session
        redirect_to :controller => "users", :action => "index"
    end

    def home 
        @users = User.all

        if(!session[:user_id])
            begin 
                @user = @users.find(params[:user_id])
            rescue ActiveRecord::RecordNotFound
                flash[:msg] = "Invalid User Id."
                redirect_to :controller => "users", :action => "login"
                return
            end
            my_password = BCrypt::Password.new(@user.password)
            if(my_password == params[:password])
                puts("\n\n\n\n Aaaa ",my_password, params[:password])
                reset_session
                session[:user_id] = @user.user_id 
            else
                flash[:msg] = "Invalid password."
                redirect_to :controller => "users", :action => "login"
            end
        else
            @user = @users.find(session[:user_id])
        end

        @lost_requests1 = LostRequest.where("user_id = '#{session[:user_id]}'")
        if(params[:search])
            search_string = (params[:search]).strip()
            @lost_requests = LostRequest.where("user_id = '#{session[:user_id]}' and (item_type like '%#{search_string}%' or color like '%#{search_string}%' or brand like '%#{search_string}%')")
        else
            @lost_requests = LostRequest.where("user_id = '#{session[:user_id]}'")
        end
    end

    def new 
        @user = User.new
    end

    def add_user
        
        @user = User.new
        @user.user_id = params[:user][:user_id]
        @user.password = params[:user][:password]
        @user.password_confirmation = params[:user][:password_confirmation]
        @user.name = params[:user][:name]
        @user.contact = params[:user][:contact]

        #Bcrypt password encryption 
        
        password_1 = BCrypt::Password.create(params[:user][:password])
        if(@user.password == "" || @user.password.length()<8 || @user.password.length()>20)
            # do nothing
        elsif(password_1 == @user.password_confirmation)
            @user.password = password_1.to_s.strip()
            @user.password_confirmation = password_1.to_s.strip()
        end
        
        # here (password_1 == @user.password_confirmation) ==> true
        # but  (@user.password_confirmation == password_1) ==> false

              
        if @user.save
            flash[:msg] = "Account created successfully."
            redirect_to :controller => 'users', :action => 'login'
            return
        else
            render "new"
            return
        end
        
        redirect_to :controller => 'users', :action => 'new'
    end


    def found_list
        if(!session[:user_id])
            redirect_to :controller => "users", :action => "login"
        else
            @user = User.find(session[:user_id])
        end

        if(params[:search])
            search_string = (params[:search]).strip()
            @found_items = FoundItem.where("status=-1 and (item_type like '%#{search_string}%' or color like '%#{search_string}%' or brand like '%#{search_string}%')")
        else
            @found_items = FoundItem.where("status=-1")
        end
    end


end
