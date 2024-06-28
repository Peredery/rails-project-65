# frozen_string_literal: true

require 'test_helper'

class Web::Admin::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @regular_user = users(:one)
    @admin_user = users(:admin)
    @drafted_bulletin = bulletins_with_file(:drafted)
    @under_moderation_bulletin = bulletins_with_file(:under_moderation)
    @published_bulletin = bulletins_with_file(:published)
  end

  test 'should not get index when not admin' do
    sign_in @regular_user

    get admin_root_path

    assert_redirected_to root_url
  end

  test 'should not get all bulletins when not admin' do
    sign_in @regular_user

    get admin_bulletins_url

    assert_redirected_to root_url
  end

  test 'should not reject bulletin when not admin' do
    sign_in @regular_user

    patch reject_admin_bulletin_url(@drafted_bulletin)

    assert_redirected_to root_url
  end

  test 'should not publish bulletin when not admin' do
    sign_in @regular_user

    patch publish_admin_bulletin_url(@drafted_bulletin)

    assert_redirected_to root_url
  end

  test 'should not archive bulletin when not admin' do
    sign_in @regular_user

    patch reject_admin_bulletin_url(@drafted_bulletin)

    assert_redirected_to root_url
  end

  test 'should publish bulletin when admin' do
    sign_in @admin_user

    patch publish_admin_bulletin_url(@under_moderation_bulletin)

    assert @under_moderation_bulletin.reload.published?
  end

  test 'should reject bulletin when admin' do
    sign_in @admin_user

    patch reject_admin_bulletin_url(@under_moderation_bulletin)

    assert @under_moderation_bulletin.reload.rejected?
  end

  test 'should archive bulletin when admin' do
    sign_in @admin_user

    patch archive_admin_bulletin_url(@under_moderation_bulletin)

    assert @under_moderation_bulletin.reload.archived?
  end

  test 'should not publish drafted bulletin when admin' do
    sign_in @admin_user

    patch publish_admin_bulletin_url(@drafted_bulletin)

    assert_redirected_to admin_bulletins_url
  end
end
