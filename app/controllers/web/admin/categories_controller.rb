# frozen_string_literal: true

class Web::Admin::CategoriesController < Web::Admin::ApplicationController
  def index
    @categories = Category.page(params[:page])
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.build(category_params)
    if @category.save
      redirect_to admin_categories_path, notice: t('.success')
    else
      render :new, alert: t('.failure'), status: :unprocessable_entity
    end
  end

  def update
    @category = Category.find(params[:id])

    if @category.update(category_params)
      redirect_to admin_categories_path, notice: t('.success')
    else
      render :edit, alert: t('.failure'), status: :unprocessable_entity
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.bulletins.exists?
      redirect_to admin_categories_path, alert: t('.cant_delete_category')
    elsif @category.destroy
      redirect_to admin_categories_path, notice: t('.success')
    else
      redirect_to admin_categories_path, alert: t('.failure'), status: :unprocessable_entity
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
