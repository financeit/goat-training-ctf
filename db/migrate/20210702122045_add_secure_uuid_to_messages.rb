class AddSecureUuidToMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :secure_uuid, :integer
  end
end
