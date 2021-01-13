class AddUserToAssociation < ActiveRecord::Migration[6.0]
  def change
    add_reference :associations, :user, null: false, foreign_key: true
  end
end
