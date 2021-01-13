class AddAssoNameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :asso_name, :string
  end
end
