module Api
  module V1
    class EventsController < ApplicationController
      before_action :set_event, only: %i[show update destroy]

      # GET /api/v1/events
      def index
        @events = Event.all
        render json: @events
      end

      # GET /api/v1/events/1
      def show
        render json: @event
      end

      # POST /api/v1/events
      def create
        @event = Event.new(event_params)
        if @event.save
          render json: @event, status: :created, location: api_v1_event_url(@event)
        else
          render json: @event.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/events/1
      def update
        if @event.update(event_params)
          render json: @event
        else
          render json: @event.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/events/1
      def destroy
        @event.destroy
        head :no_content
      end

      private

      def set_event
        @event = Event.find(params[:id])
      end

      def event_params
        params.require(:event).permit(:name, :date, :location)
      end
    end
  end
end
