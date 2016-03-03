class AddExpiresAtToAuthentications < ActiveRecord::Migration
  def change
    add_column :authentications, :expires_at, :datetime
  end
end
