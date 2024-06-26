# frozen_string_literal: true

class Web::AuthController < Web::ApplicationController
  def callback
    auth_params = request.env['omniauth.auth'][:info]

    user = Builders::UserBuilder.build(auth_params)

    if user
      sign_in(user)
      redirect_to root_path, notice: t('.login.success')
    else
      redirect_to root_path, alert: t('.login.failure')
    end
  end

  def destroy
    logout(current_user)
    redirect_to root_path, notice: t('.logout.success')
  end
end
