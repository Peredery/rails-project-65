class CreateBulletins < ActiveRecord::Migration[7.1]
  def change
    create_table :bulletins do |t|
      t.string :title, null: false, index: { unique: true }
      t.text :description, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
