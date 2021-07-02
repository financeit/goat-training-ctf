class AddShowSecureTokenToPays < ActiveRecord::Migration[5.1]
  def change
    add_column :pays, :show_secure_token, :boolean
  end
end
