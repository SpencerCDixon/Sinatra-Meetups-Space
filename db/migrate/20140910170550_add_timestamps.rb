class AddTimestamps < ActiveRecord::Migration
  def up
    add_column(:meetups, :created_at, :datetime)
    add_column(:meetups, :updated_at, :datetime)
    add_column(:joined_meetups, :created_at, :datetime)
    add_column(:joined_meetups, :updated_at, :datetime)
  end

  def down
    remove_column(:meetups, :created_at, :datetime)
    remove_column(:meetups, :updated_at, :datetime)
    remove_column(:joined_meetups, :created_at, :datetime)
    remove_column(:joined_meetups, :updated_at, :datetime)
  end
end
