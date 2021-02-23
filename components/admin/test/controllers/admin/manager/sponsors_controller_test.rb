require "test_helper"

module Admin
  class Manager::SponsorsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @manager_sponsor = admin_manager_sponsors(:one)
    end

    test "should get index" do
      get manager_sponsors_url
      assert_response :success
    end

    test "should get new" do
      get new_manager_sponsor_url
      assert_response :success
    end

    test "should create manager_sponsor" do
      assert_difference('Manager::Sponsor.count') do
        post manager_sponsors_url, params: { manager_sponsor: {  } }
      end

      assert_redirected_to manager_sponsor_url(Manager::Sponsor.last)
    end

    test "should show manager_sponsor" do
      get manager_sponsor_url(@manager_sponsor)
      assert_response :success
    end

    test "should get edit" do
      get edit_manager_sponsor_url(@manager_sponsor)
      assert_response :success
    end

    test "should update manager_sponsor" do
      patch manager_sponsor_url(@manager_sponsor), params: { manager_sponsor: {  } }
      assert_redirected_to manager_sponsor_url(@manager_sponsor)
    end

    test "should destroy manager_sponsor" do
      assert_difference('Manager::Sponsor.count', -1) do
        delete manager_sponsor_url(@manager_sponsor)
      end

      assert_redirected_to manager_sponsors_url
    end
  end
end
