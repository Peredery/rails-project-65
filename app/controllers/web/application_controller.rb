# frozen_string_literal: true

class Web::ApplicationController < ApplicationController
  include Authenticatable
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :authorize_error

  private

  def authorize_error
    redirect_back fallback_location: root_path, alert: t('not_authorized')
  end
end
