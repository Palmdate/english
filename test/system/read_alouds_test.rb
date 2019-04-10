require "application_system_test_case"

class ReadAloudsTest < ApplicationSystemTestCase
  setup do
    @read_aloud = read_alouds(:one)
  end

  test "visiting the index" do
    visit read_alouds_url
    assert_selector "h1", text: "Read Alouds"
  end

  test "creating a Read aloud" do
    visit read_alouds_url
    click_on "New Read Aloud"

    click_on "Create Read aloud"

    assert_text "Read aloud was successfully created"
    click_on "Back"
  end

  test "updating a Read aloud" do
    visit read_alouds_url
    click_on "Edit", match: :first

    click_on "Update Read aloud"

    assert_text "Read aloud was successfully updated"
    click_on "Back"
  end

  test "destroying a Read aloud" do
    visit read_alouds_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Read aloud was successfully destroyed"
  end
end
