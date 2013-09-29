class CreateMartialartsTechniques < ActiveRecord::Migration
  def change
    create_table :martialarts_techniques do |t|
      t.belongs_to :martialart
      t.belongs_to :technique
    end    
  end
end
