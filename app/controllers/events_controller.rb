class EventsController < ApplicationController
  before_action :user_signed_in, only: %i[ new create ]
  before_action :set_event, only: %i[ show edit update destroy ]
  before_action :user_is_creator, only: %i[ edit update destroy ]

  # GET /events
  def index
    @events = Event.all
  end

  # GET /events/1
  def show
  end

  # GET /events/new
  def new
    @event = Event.new(date: DateTime.now + 1)
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  def create
    @event = current_user.created_events.new(event_params)

    if @event.save
      redirect_to @event, notice: "Event was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      redirect_to @event, notice: "Event was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy!
    redirect_to events_url, notice: "Event was successfully destroyed.", status: :see_other
  end

  private
    # Users must be signed in to create events
    def user_signed_in
      if !user_signed_in?
        redirect_to new_user_session_path
      end
    end

    # Users can only modify their own events
    def user_is_creator
      if @event.creator != current_user
        redirect_to new_user_session_path
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:name, :date)
    end
end
