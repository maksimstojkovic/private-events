class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :created_events, foreign_key: :creator, class_name: "Event"

  has_many :event_attendees, foreign_key: :attendee
  has_many :attended_events, through: :event_attendees, source: :event
end
