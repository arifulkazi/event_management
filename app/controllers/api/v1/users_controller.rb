class Api::V1::UsersController < ApplicationController

    # See all users who sign up for an event
	# GET api/v1/events/#(event id)/users
	def index
		@val = params[:event_id]
		@user = User.where("event_id = "+@val)
    	render json: @user
    end

     # Remove email(user) address from event
    # DELETE  api/v1/events/#(event id)/users/#(user id)
    def destroy
    	@event_id = params[:event_id]
    	@user_id = params[:id]
      	@user = User.where(event_id: + @event_id + ",",id: +@user_id)
    	#render json:@user
    	if not @user.exists?
    		 render :json => { :message => 'Event is not matching with user' } , status: 400
    	end

        @user = User.find(params[:id])

        if @user
            @user.destroy()
             ActionMailer::Base.mail(
              from: "me@example.com",
              to: @user['email'],
              subject: "Remove event",
              body: "Your event," + @event_id + " has beed removed"
            ).deliver
            render :json => { :message => 'Successfully deleted' }, status: 200

        else
            render :json => { :message => 'Invalid user' } , status: 400
        end
    end
end
