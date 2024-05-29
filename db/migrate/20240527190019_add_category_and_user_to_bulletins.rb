class AddCategoryAndUserToBulletins < ActiveRecord::Migration[7.1]
  def change
    add_reference :bulletins, :category, null: false, foreign_key: true
    add_reference :bulletins, :user, null: false, foreign_key: true
  end
end
