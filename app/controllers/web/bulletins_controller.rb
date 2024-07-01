# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update to_moderate archive]

  def index
    @q = Bulletin.published.order(updated_at: :desc).ransack(params[:q])

    @bulletins = @q.result.page(params[:page])
    @categories = Category.order(name: :asc)
  end

  def show
    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin
  end

  def new
    @bulletin = current_user.bulletins.new
  end

  def edit
    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin
  end

  def create
    @bulletin = current_user.bulletins.build(bulletin_params)

    if @bulletin.save
      redirect_to @bulletin, notice: t('.success')
    else
      render :new, alert: t('.failure'), status: :unprocessable_entity
    end
  end

  def update
    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin

    if @bulletin.update(bulletin_params)
      redirect_to @bulletin, notice: t('.success')
    else
      render :edit, alert: t('.failure'), status: :unprocessable_entity
    end
  end

  def to_moderate
    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin

    if @bulletin.may_to_moderate?
      @bulletin.to_moderate!
      flash[:notice] = t('.success')
    else
      flash[:alert] = t('.failure')
    end
    redirect_to :profile
  end

  def archive
    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin

    if @bulletin.may_archive?
      @bulletin.archive!
      flash[:notice] = t('.success')
    else
      flash[:alert] = t('.failure')
    end
    redirect_to :profile
  end

  private

  def bulletin_params
    params.require(:bulletin).permit(:title, :category_id, :description, :image)
  end
end
