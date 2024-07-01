# frozen_string_literal: true

require 'test_helper'

class Web::BulletinControllerTest < ActionDispatch::IntegrationTest
  setup do
    @published_bulletin = bulletins(:published)
    @drafted_bulletin = bulletins(:drafted)
    @current_user = users(:one)
    @bulletin_attrs = {
      bulletin: {
        title: Faker::Lorem.sentence,
        description: Faker::Lorem.paragraph,
        image: fixture_file_upload('test_image_1.png', 'image/png'),
        category_id: Category.last.id
      }
    }
  end

  test 'should get index' do
    get root_path

    assert :success
  end

  test 'should get show' do
    get bulletin_url(@published_bulletin)

    assert_response :success
  end

  test 'should not get show when bulletin is drafted from different user' do
    sign_in(users(:two))
    get bulletin_url(@drafted_bulletin)

    assert_redirected_to root_url
  end

  test 'should get new for logged in user' do
    sign_in(@current_user)
    get new_bulletin_url

    assert_response :success
  end

  test 'should not get new for not logged in user' do
    get new_bulletin_url

    assert_redirected_to root_url
  end

  test 'should create bulletin for logged in user' do
    sign_in(@current_user)
    post bulletins_url, params: @bulletin_attrs

    assert_redirected_to bulletin_url(Bulletin.last)
    assert Bulletin.find_by(title: @bulletin_attrs[:bulletin][:title])
  end

  test 'should not create bulletin for not logged in user' do
    post bulletins_url, params: @bulletin_attrs

    assert_redirected_to root_url
    assert_not Bulletin.find_by(title: @bulletin_attrs[:bulletin][:title])
  end

  test 'should get edit for logged in user' do
    sign_in(@current_user)
    get edit_bulletin_url(@published_bulletin)

    assert_response :success
  end

  test 'should not get edit for not author' do
    sign_in(users(:two))
    get edit_bulletin_url(@published_bulletin)

    assert_redirected_to root_url
  end

  test 'should update bulletin for author' do
    sign_in(@current_user)
    patch bulletin_url(@published_bulletin), params: @bulletin_attrs

    assert_redirected_to bulletin_url(@published_bulletin)
    assert @published_bulletin.reload.title == @bulletin_attrs[:bulletin][:title]
    assert @published_bulletin.reload.description == @bulletin_attrs[:bulletin][:description]
  end

  test 'should not update bulletin for not author' do
    sign_in(users(:two))
    patch bulletin_url(@published_bulletin), params: @bulletin_attrs

    assert_redirected_to root_url
    assert @published_bulletin.reload.title != @bulletin_attrs[:bulletin][:title]
  end

  test 'should move to moderate for author' do
    sign_in(@current_user)
    patch to_moderate_bulletin_url(@drafted_bulletin)

    assert_redirected_to profile_url
    assert @drafted_bulletin.reload.under_moderation?
  end

  test 'should not move to moderate for not author' do
    sign_in(users(:two))
    patch to_moderate_bulletin_url(@drafted_bulletin)

    assert_redirected_to root_path
    assert_not @drafted_bulletin.reload.under_moderation?
  end

  test 'should move to archive for author' do
    sign_in(@current_user)
    patch archive_bulletin_url(@published_bulletin)

    assert_redirected_to profile_url
    assert @published_bulletin.reload.archived?
  end

  test 'should not move to archive for not author' do
    sign_in(users(:two))
    patch archive_bulletin_url(@published_bulletin)

    assert_redirected_to root_path
    assert_not @published_bulletin.reload.archived?
  end
end
