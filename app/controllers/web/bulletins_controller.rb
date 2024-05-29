# frozen_string_literal: true

class Web::BulletinsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def index
    @bulletins = Bulletin.order(created_at: :desc)
  end

  def show
    @bulletin = Bulletin.find(params[:id])
  end

  def new
    @bulletin = current_user.bulletins.new
  end

  def create
    @bulletin = current_user.bulletins.build(bulletin_params)

    if @bulletin.save
      redirect_to @bulletin, notice: t('.success')
    else
      render :new, alert: t('.failure'), status: :unprocessable_entity
    end
  end

  private

  def bulletin_params
    params.require(:bulletin).permit(:title, :category_id, :description, :user_id, :image)
  end
end
