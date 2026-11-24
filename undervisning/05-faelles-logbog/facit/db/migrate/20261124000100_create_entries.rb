class CreateEntries < ActiveRecord::Migration[8.1]
  def change
    create_table :entries do |t|
      t.string :pirat, null: false
      t.text :tekst, null: false
      t.timestamps
    end
  end
end
