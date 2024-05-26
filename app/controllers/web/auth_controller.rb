# frozen_string_literal: true

class Web::AuthController < ApplicationController
  def callback
    auth_params = request.env['omniauth.auth'][:info]

    user = Builders::UserBuilder.build(auth_params)

    if user
      sign_in(user)
      redirect_to root_path
    else
      redirect_to root_path
    end
  end
end
