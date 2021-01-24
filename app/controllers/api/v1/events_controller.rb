class Api::V1::EventsController < ApplicationController
    #List all events
    #GET /api/v1/events/
    def index
    	@event = Event.all
    	render json: @event
    end

    #Show an events
    #GET /api/v1/events/#event_id
    def show
    	@event = Event.find(params[:id])
    	render json: @event
    	
    end
end
