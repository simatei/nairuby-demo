class AttendancesController < ApplicationController
  before_action :set_event, only: [:new, :create]

  def new
    @attendance = @event.attendances.build
  end

  def create
    @attendance = @event.attendances.build(attendance_params)

    if @attendance.save
      redirect_to @event, notice: 'Thank you for confirming your attendance.'
    else
      render :new
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to events_path, alert: 'Event not found.'
  end

  def attendance_params
    params.require(:attendance).permit(:user_name, :email, :phone_number)
  end
end
