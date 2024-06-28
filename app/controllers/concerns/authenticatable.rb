# frozen_string_literal: true

module Authenticatable
  extend ActiveSupport::Concern

  included do
    helper_method :current_user, :user_signed_in?
  end

  def authenticate_user!
    redirect_to root_path, alert: t('need_login') unless current_user
  end

  def authorize_admin!
    authenticate_user!

    redirect_to root_path unless current_user.admin?
  end

  def current_user
    Current.user || authenticate_user_from_session
  end

  def user_signed_in?
    current_user.present?
  end

  def authenticate_user_from_session
    User.find_by(id: session[:user_id])
  end

  def sign_in(user)
    Current.user = user
    reset_session
    session[:user_id] = user.id
  end

  def logout(_user)
    Current.user = nil
    reset_session
  end
end
