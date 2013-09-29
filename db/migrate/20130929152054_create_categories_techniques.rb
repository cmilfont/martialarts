class CreateCategoriesTechniques < ActiveRecord::Migration
  def change
    create_table :categories_techniques do |t|
      t.belongs_to :category
      t.belongs_to :technique
    end
  end
end
