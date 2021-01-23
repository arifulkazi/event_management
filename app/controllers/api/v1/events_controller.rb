class Api::V1::EventsController < ApplicationController
    #List all events
    #GET /api/v1/events/
	def index
    	@event = Event.all
    	render json: @event
    end

    #GET /api/v1/events/#
    def show
    	@event = Event.find(params[:id])
    	render json: @event
    	
    end

    #Signup event for an event
    # PUT /api/v1/events/#(event number)/
    def update
        @event = Event.find(params[:id])
    
        if @event
            @email = params.permit(:email)
            @email_val = @email['email']
            @u_id = params[:id]
            @user_exists = User.where(event_id: + @u_id ,email: +@email_val)

            if(@user_exists.exists?)
                render :json => { :message => 'This event is already sign up for this user' }, status: 400
                return
            end 
            @user = User.new(event_id: + @u_id ,email: +@email_val)
            if @user.save
                @message = "Event sign up successfuly. user id:" + @user['id'].to_s
                 render :json => { :message => @message }, status: 200
            else
                render :json => { :message => 'Event sign up faild' }, status: 400
            end
        else
             render :json => { :message => 'Event is not available' } , status: 400
        end
    end

    
    def event_params
    	params.permit(:name, :location, :start_time, :end_time)
   
    end

    def user_params
        params.permit(:email)
   
    end 	
end
