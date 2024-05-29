# frozen_string_literal: true

# == Schema Information
#
# Table name: bulletins
#
#  id          :integer          not null, primary key
#  description :text             not null
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer          not null
#  user_id     :integer          not null
#
# Indexes
#
#  index_bulletins_on_category_id  (category_id)
#  index_bulletins_on_description  (description) UNIQUE
#  index_bulletins_on_title        (title) UNIQUE
#  index_bulletins_on_user_id      (user_id)
#
# Foreign Keys
#
#  category_id  (category_id => categories.id)
#  user_id      (user_id => users.id)
#
class Bulletin < ApplicationRecord
  has_one_attached :image
  belongs_to :category
  belongs_to :user

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :image, presence: true, attached: true, content_type: { in: ['image/jpeg', 'image/png', 'image/webp'], message: I18n.t('.image_mime_type') },
                    size: { less_than: 5.megabytes, message: I18n.t('.image_size') }
end
