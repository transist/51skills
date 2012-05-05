require 'test_helper'

class RedirectionControllerTest < ActionController::TestCase
  test "should get ted" do
    get :ted
    assert_response :success
  end

  test "should get tedx" do
    get :tedx
    assert_response :success
  end

  test "should get tedxshanghai" do
    get :tedxshanghai
    assert_response :success
  end

  test "should get join" do
    get :join
    assert_response :success
  end

  test "should get friends" do
    get :friends
    assert_response :success
  end

  test "should get support" do
    get :support
    assert_response :success
  end

  test "should get sponsors" do
    get :sponsors
    assert_response :success
  end

end
