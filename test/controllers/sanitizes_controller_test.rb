require 'test_helper'

class SanitizesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sanitize = sanitizes(:one)
  end

  test "should get index" do
    get sanitizes_url
    assert_response :success
  end

  test "should get new" do
    get new_sanitize_url
    assert_response :success
  end

  test "should create sanitize" do
    assert_difference('Sanitize.count') do
      post sanitizes_url, params: { sanitize: { description: @sanitize.description, match: @sanitize.match, result: @sanitize.result, status: @sanitize.status } }
    end

    assert_redirected_to sanitize_url(Sanitize.last)
  end

  test "should show sanitize" do
    get sanitize_url(@sanitize)
    assert_response :success
  end

  test "should get edit" do
    get edit_sanitize_url(@sanitize)
    assert_response :success
  end

  test "should update sanitize" do
    patch sanitize_url(@sanitize), params: { sanitize: { description: @sanitize.description, match: @sanitize.match, result: @sanitize.result, status: @sanitize.status } }
    assert_redirected_to sanitize_url(@sanitize)
  end

  test "should destroy sanitize" do
    assert_difference('Sanitize.count', -1) do
      delete sanitize_url(@sanitize)
    end

    assert_redirected_to sanitizes_url
  end
end
