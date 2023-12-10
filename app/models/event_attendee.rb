class EventAttendee < ApplicationRecord
  belongs_to :event
  belongs_to :attendee, foreign_key: :user, class_name: "User"
end
