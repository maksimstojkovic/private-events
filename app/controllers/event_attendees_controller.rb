class EventAttendeesController < ApplicationController
  before_action :user_signed_in, only: %i[ create ]
  before_action :set_event, only: %i[ create destroy ]
  before_action :set_event_attendee, only: %i[ destroy ]
  before_action :user_is_attendee, only: %i[ destroy ]

  # GET /event_attendees
  # def index
  #   @event_attendees = EventAttendee.all
  # end

  # GET /event_attendees/1
  # def show
  # end

  # GET /event_attendees/new
  # def new
  #   @event_attendee = @event.event_attendees.build(attendee_id: current_user.id)
  # end

  # GET /event_attendees/1/edit
  # def edit
  # end

  # POST /event_attendees
  def create
    if EventAttendee.exists?(event_id: @event.id, attendee_id: current_user.id)
      redirect_to @event, notice: "Already registered for event."
    else
      @event_attendee = @event.event_attendees.new(attendee_id: current_user.id)
  
      if @event_attendee.save
        redirect_to @event, notice: "Event attendee was successfully created."
      else
        render @event, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /event_attendees/1
  # def update
  #   if @event_attendee.update(event_attendee_params)
  #     redirect_to @event_attendee, notice: "Event attendee was successfully updated.", status: :see_other
  #   else
  #     render :edit, status: :unprocessable_entity
  #   end
  # end

  # DELETE /event_attendees/1
  def destroy
    @event_attendee.destroy!
    redirect_to @event, notice: "Event attendee was successfully destroyed.", status: :see_other
  end

  private
    # Users must be signed in to attend events
    def user_signed_in
      if !user_signed_in?
        redirect_to new_user_session_path
      end
    end

    # Users can only modify their own event attendance
    def user_is_attendee
      if @event_attendee.attendee != current_user
        redirect_to new_user_session_path
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    def set_event_attendee
      @event_attendee = EventAttendee.find(params[:attend_id])
    end

    # # Only allow a list of trusted parameters through.
    # def event_attendee_params
    #   params.require(:event_attendee).permit(:attendee_id)
    # end
end
