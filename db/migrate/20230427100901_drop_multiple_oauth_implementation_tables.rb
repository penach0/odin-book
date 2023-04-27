class DropMultipleOauthImplementationTables < ActiveRecord::Migration[7.0]
  def change
    drop_table :social_accounts
    drop_table :user_authentications
    drop_table :authentication_providers
  end
end
