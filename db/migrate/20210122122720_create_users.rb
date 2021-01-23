class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.references :event, null: false, foreign_key: true
      t.string :email, null: false

      t.timestamps
    end
  end
end
