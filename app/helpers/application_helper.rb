# frozen_string_literal: true

module ApplicationHelper
  def resized_image(record, width, height)
    return unless record.image.attached?

    record.image.variant(resize_to_limit: [300, 300])
  end
end
