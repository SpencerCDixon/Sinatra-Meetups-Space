class JoinedMeetup < ActiveRecord::Base
  belongs_to :meetup
  belongs_to :user

  validates :uid, presence: true
  validates :meetup_id, presence: true
end
