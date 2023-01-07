class CreateInterests < ActiveRecord::Migration[6.1]
  def change
    create_table :interests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :ski_resort, null: false, foreign_key: true

      t.timestamps
    end
  end
end
