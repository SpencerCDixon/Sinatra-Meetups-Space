class Meetup < ActiveRecord::Base
  has_many :joined_meetups

  validates :name, presence: true
  validates :location, presence: true
end
