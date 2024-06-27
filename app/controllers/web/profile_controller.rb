# frozen_string_literal: true

class Web::ProfileController < Web::ApplicationController
  before_action :authenticate_user!

  def index
    @bulletins = current_user.bulletins.page(params[:page])
  end
end
