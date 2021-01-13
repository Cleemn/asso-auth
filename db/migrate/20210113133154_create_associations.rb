class CreateAssociations < ActiveRecord::Migration[6.0]
  def change
    create_table :associations do |t|
      t.string :name
      t.string :rna_id
      t.string :official_id

      t.timestamps
    end
  end
end
