class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"
  
  has_many :event_attendees #, foreign_key: :event
  has_many :attendees, through: :event_attendees, source: :attendee, class_name: "User"

  scope :past_events, -> { where(date: ...(DateTime.now)) }
  scope :upcoming_events, -> { where(date: (DateTime.now)...) }
end
