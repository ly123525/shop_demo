class AddUuidToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :uuid, :string

    add_index :users, [:uuid], unique: true
  end
end
