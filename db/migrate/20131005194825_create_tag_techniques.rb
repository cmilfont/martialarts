class CreateTagTechniques < ActiveRecord::Migration
  def change
    create_table :tag_techniques do |t|
      t.belongs_to :tag, index: true
      t.belongs_to :technique, index: true

      t.timestamps
    end
  end
end
