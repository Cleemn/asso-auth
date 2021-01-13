class AddRnaToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :rna, :string
  end
end
