require "test_helper"

module Admin
  class Manager::AdminsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @manager_admin = admin_manager_admins(:one)
    end

    test "should get index" do
      get manager_admins_url
      assert_response :success
    end

    test "should get new" do
      get new_manager_admin_url
      assert_response :success
    end

    test "should create manager_admin" do
      assert_difference('Manager::Admin.count') do
        post manager_admins_url, params: { manager_admin: {  } }
      end

      assert_redirected_to manager_admin_url(Manager::Admin.last)
    end

    test "should show manager_admin" do
      get manager_admin_url(@manager_admin)
      assert_response :success
    end

    test "should get edit" do
      get edit_manager_admin_url(@manager_admin)
      assert_response :success
    end

    test "should update manager_admin" do
      patch manager_admin_url(@manager_admin), params: { manager_admin: {  } }
      assert_redirected_to manager_admin_url(@manager_admin)
    end

    test "should destroy manager_admin" do
      assert_difference('Manager::Admin.count', -1) do
        delete manager_admin_url(@manager_admin)
      end

      assert_redirected_to manager_admins_url
    end
  end
end
