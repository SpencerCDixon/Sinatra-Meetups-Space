class CreateComment < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :meetup_id, null: false
      t.integer :user_id, null: false
      t.text :body, null: false
      t.string :title

      t.timestamps
    end
  end
end
