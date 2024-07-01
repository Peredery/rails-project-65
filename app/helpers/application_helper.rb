# frozen_string_literal: true

module ApplicationHelper
  FLASH_CLASSES = { 'notice' => 'alert-success', 'alert' => 'alert-warning', 'error' => 'alert-danger' }.freeze

  def resized_image(record, width, height)
    return unless record.image.attached?

    record.image.variant(resize_to_limit: [width, height])
  end

  def flash_classes(type)
    FLASH_CLASSES[type]
  end
end
