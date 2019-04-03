require "application_system_test_case"

class WriteFrDicsTest < ApplicationSystemTestCase
  setup do
    @write_fr_dic = write_fr_dics(:one)
  end

  test "visiting the index" do
    visit write_fr_dics_url
    assert_selector "h1", text: "Write Fr Dics"
  end

  test "creating a Write fr dic" do
    visit write_fr_dics_url
    click_on "New Write Fr Dic"

    click_on "Create Write fr dic"

    assert_text "Write fr dic was successfully created"
    click_on "Back"
  end

  test "updating a Write fr dic" do
    visit write_fr_dics_url
    click_on "Edit", match: :first

    click_on "Update Write fr dic"

    assert_text "Write fr dic was successfully updated"
    click_on "Back"
  end

  test "destroying a Write fr dic" do
    visit write_fr_dics_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Write fr dic was successfully destroyed"
  end
end
