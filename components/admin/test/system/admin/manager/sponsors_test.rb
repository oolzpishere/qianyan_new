require "application_system_test_case"

module Admin
  class Manager::SponsorsTest < ApplicationSystemTestCase
    setup do
      @manager_sponsor = admin_manager_sponsors(:one)
    end

    test "visiting the index" do
      visit manager_sponsors_url
      assert_selector "h1", text: "Manager/Sponsors"
    end

    test "creating a Sponsor" do
      visit manager_sponsors_url
      click_on "New Manager/Sponsor"

      click_on "Create Sponsor"

      assert_text "Sponsor was successfully created"
      click_on "Back"
    end

    test "updating a Sponsor" do
      visit manager_sponsors_url
      click_on "Edit", match: :first

      click_on "Update Sponsor"

      assert_text "Sponsor was successfully updated"
      click_on "Back"
    end

    test "destroying a Sponsor" do
      visit manager_sponsors_url
      page.accept_confirm do
        click_on "Destroy", match: :first
      end

      assert_text "Sponsor was successfully destroyed"
    end
  end
end
