class CreateMartialartTechniques < ActiveRecord::Migration
  def change
    create_table :martialart_techniques do |t|
      t.belongs_to :martialart
      t.belongs_to :technique
      t.timestamps
    end
  end
end
