class AddCollumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :nickname, :string
    add_column :users, :location, :string
    add_column :users, :link_facebook, :string
    add_column :users, :locale, :string
    add_column :users, :facebook_id, :string
    add_column :users, :picture_facebook_square, :string
    add_column :users, :picture_facebook_small, :string
    add_column :users, :picture_facebook_normal, :string
    add_column :users, :picture_facebook_large, :string
    add_column :users, :token_facebook, :string
    add_column :users, :provider, :string
    add_column :users, :uid, :string
  end
end
