class Meetup < ActiveRecord::Base
  has_many :joined_meetups
  has_many :users, through: :joined_meetups
  has_many :comments

  validates :name, presence: true
  validates :location, presence: true
end
