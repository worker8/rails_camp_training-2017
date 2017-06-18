class CreateCredentials < ActiveRecord::Migration[5.1]
  def change
    create_table :credentials do |t|
      t.string :access_token, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :credentials, :access_token, unique: true
  end
end
