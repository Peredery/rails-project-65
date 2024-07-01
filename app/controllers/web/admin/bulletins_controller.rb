# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  def index
    @q = Bulletin.public_send(params[:filter_state]).ransack(params[:q])
    @bulletins = @q.result.page(params[:page]).order(id: :asc)
  end

  def reject
    @bulletin = Bulletin.find(params[:id])

    if @bulletin.may_reject?
      @bulletin.reject!
      flash[:notice] = t('.success')
    else
      flash[:alert] = t('.failure')
    end
    redirect_back fallback_location: admin_bulletins_path
  end

  def publish
    @bulletin = Bulletin.find(params[:id])

    if @bulletin.may_publish?
      @bulletin.publish!
      flash[:notice] = t('.success')
    else
      flash[:alert] = t('.failure')
    end
    redirect_back fallback_location: admin_bulletins_path
  end

  def archive
    @bulletin = Bulletin.find(params[:id])

    if @bulletin.may_archive?
      @bulletin.archive!
      flash[:notice] = t('.success')
    else
      flash[:alert] = t('.failure')
    end
    redirect_back fallback_location: admin_bulletins_path
  end
end
