class CreateJoinedMeetup < ActiveRecord::Migration
  def change
    create_table :joined_meetups do |t|
      t.integer :meetup_id, null: false
      t.integer :user_id, null: false
    end
  end
end
