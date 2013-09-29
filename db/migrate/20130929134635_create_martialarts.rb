class CreateMartialarts < ActiveRecord::Migration
  def change
    create_table :martialarts do |t|
      t.string :name
      t.text :description
      t.timestamps
    end
  end
end
