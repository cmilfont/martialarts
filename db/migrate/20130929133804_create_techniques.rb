class CreateTechniques < ActiveRecord::Migration
  def change
    create_table :techniques do |t|
      t.string :name
      t.text :description
      t.belongs_to :user

      t.timestamps
    end
  end
end
