class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.belongs_to :technique
      t.belongs_to :user
      t.string :link
      t.timestamps
    end
  end
end
