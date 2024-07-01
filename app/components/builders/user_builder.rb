# frozen_string_literal: true

class Builders::UserBuilder
  class << self
    def build(auth_params)
      User.find_or_initialize_by(email: auth_params[:email]).tap do |user|
        user.email = auth_params[:email]
        user.name = auth_params[:name]
        user.save
      end
    end
  end
end
