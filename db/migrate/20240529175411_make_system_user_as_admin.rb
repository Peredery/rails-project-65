# frozen_string_literal: true

class MakeSystemUserAsAdmin < ActiveRecord::Migration[7.1]
  def up
    email = ENV.fetch('ADMIN_EMAIL', nil)

    if email
      user = User.find_by(email:)

      if user
        user.update(admin: true)
        Rails.logger.debug { "User #{email} is now an admin." }
      else
        Rails.logger.debug { "No user found with email #{email}." }
      end
    else
      Rails.logger.debug "ENV['ADMIN_EMAIL'] is not set."
    end
  end

  def down
    email = ENV.fetch('ADMIN_EMAIL', nil)

    if email
      user = User.find_by(email:)

      if user
        user.update(admin: false)
        Rails.logger.debug { "User #{email} is no longer an admin." }
      else
        Rails.logger.debug { "No user found with email #{email}." }
      end
    else
      Rails.logger.debug "ENV['ADMIN_EMAIL'] is not set."
    end
  end
end
