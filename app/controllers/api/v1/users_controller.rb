class Api::V1::UsersController < ApplicationController

    # See all users who sign up for an event
    # GET api/v1/events/#(event id)/users
    def index
  	  @val = params[:event_id]
  	  @user = User.where("event_id = "+@val)
    	render json: @user
    end

    #Signup user for an event
    # POST /api/v1/events/#(event number)
    def create
        @event = Event.find(params[:event_id])
        if @event
            @email = params.permit(:email)
            @email_val = @email['email']
            @e_id = params[:event_id]
            @user_exists = User.where(event_id: + @e_id ,email: +@email_val)

            if(@user_exists.exists?)
                render :json => { :message => 'This event is already sign up for this user' }, status: 400
                return
            end 
            @user = User.new(event_id: + @e_id ,email: +@email_val)
            if @user.save
                @message = "Event," + @e_id + " sign up successfuly. user id:" +
                                          @user['id'].to_s + " email:" + @email_val
                ActionMailer::Base.mail(
                from: "me@example.com",
                to: ENV['USER_NAME'],
                subject: "Signup event",
                body: @message
                 ).deliver
                render :json => { :message => @message }, status: 200
            else
                render :json => { :message => 'Event sign up faild' }, status: 400
            end
        else
             render :json => { :message => 'Event is not available' } , status: 400
        end
    end

    # Remove email(user) address from event
    # DELETE  api/v1/events/#event_id/users/#user_id
    def destroy
    	@event_id = params[:event_id]
    	@user_id = params[:id]
      	@user = User.where(event_id: + @event_id + ",",id: +@user_id)
    	if not @user.exists?
    		 render :json => { :message => 'Event is not matching with user' } , status: 400
    	end

        @user = User.find(params[:id])

        if @user
            @user.destroy()
            @message = "Event," + @event_id + " has beed removed. user id:" +
                                          @user_id.to_s + " email:" + @user['email']
             ActionMailer::Base.mail(
              from: "me@example.com",
              to:  ENV['USER_NAME'],
              subject: "Remove event",
              body: @message
            ).deliver
            render :json => { :message => 'Successfully deleted' }, status: 200

        else
            render :json => { :message => 'Invalid user' } , status: 400
        end
    end
end
