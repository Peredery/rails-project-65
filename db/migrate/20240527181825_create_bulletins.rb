# frozen_string_literal: true

class CreateBulletins < ActiveRecord::Migration[7.1]
  def change
    create_table :bulletins do |t|
      t.string :title, null: false
      t.text :description, null: false

      t.timestamps
    end
  end
end
