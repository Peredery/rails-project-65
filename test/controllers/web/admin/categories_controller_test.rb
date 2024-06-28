# frozen_string_literal: true

require 'test_helper'

class Web::Admin::CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @regular_user = users(:one)
    @category = categories(:one)
    @admin_user = users(:admin)
    @update_params = { category: { name: 'New name' } }
    @create_params = { category: { name: 'New category' } }
  end

  test 'should not get index when not admin' do
    sign_in @regular_user

    get admin_categories_url

    assert_redirected_to root_url
  end

  test 'should not get new when not admin' do
    sign_in @regular_user

    get new_admin_category_url

    assert_redirected_to root_url
  end

  test 'should not get edit when not admin' do
    sign_in @regular_user

    get edit_admin_category_path(@category)

    assert_redirected_to root_url
  end

  test 'should not update when not admin' do
    sign_in @regular_user

    patch admin_category_url(@category), params: @update_params
    assert @category.reload.name != @update_params[:category][:name]
  end

  test 'should not delete category when not admin' do
    sign_in @regular_user

    delete admin_category_url(@category)
    assert Category.exists?(@category.id)
  end

  test 'should get new when admin' do
    sign_in @admin_user

    get new_admin_category_url

    assert_response :success
  end

  test 'should create category when admin' do
    sign_in @admin_user

    post admin_categories_url, params: @create_params
    assert Category.exists?(name: @create_params[:category][:name])
  end

  test 'should get edit when admin' do
    sign_in @admin_user

    get edit_admin_category_path(@category)

    assert_response :success
  end

  test 'should update category when admin' do
    sign_in @admin_user

    patch admin_category_url(@category), params: @update_params
    assert @category.reload.name == @update_params[:category][:name]
  end

  test 'should delete category when admin' do
    sign_in @admin_user

    delete admin_category_url(@category)
    assert_not Category.exists?(@category.id)
  end

  test 'should get index when admin' do
    sign_in @admin_user

    get admin_categories_url

    assert_response :success
  end
end
