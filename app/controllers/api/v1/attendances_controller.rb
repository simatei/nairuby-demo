module Api
  module V1
    class AttendancesController < ApplicationController
      before_action :set_event

      # GET /api/v1/events/:event_id/attendances
      def index
        @attendances = @event.attendances.all
        render json: @attendances
      end

      # POST /api/v1/events/:event_id/attendances
      def create
        @attendance = @event.attendances.build(attendance_params)

        if @attendance.save
          render json: @attendance, status: :created, location: api_v1_event_attendance_url(@event, @attendance)
        else
          render json: @attendance.errors, status: :unprocessable_entity
        end
      end

      private

      def set_event
        @event = Event.find(params[:event_id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Event not found' }, status: :not_found
      end

      def attendance_params
        # Add the necessary parameters here
        params.require(:attendance).permit(:user_name, :email, :phone_number)
      end
    end
  end
end
