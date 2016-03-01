class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.string :provider
      t.string :uid
      t.string :token
      t.string :secret
      t.string :name
      t.string :image
      t.string :location
      t.string :url
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
