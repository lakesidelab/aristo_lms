require "application_system_test_case"

module AristoLms
  class QuestionsTest < ApplicationSystemTestCase
    setup do
      @question = aristo_lms_questions(:one)
    end

    test "visiting the index" do
      visit questions_url
      assert_selector "h1", text: "Questions"
    end

    test "creating a Question" do
      visit questions_url
      click_on "New Question"

      fill_in "Question text", with: @question.question_text
      click_on "Create Question"

      assert_text "Question was successfully created"
      click_on "Back"
    end

    test "updating a Question" do
      visit questions_url
      click_on "Edit", match: :first

      fill_in "Question text", with: @question.question_text
      click_on "Update Question"

      assert_text "Question was successfully updated"
      click_on "Back"
    end

    test "destroying a Question" do
      visit questions_url
      page.accept_confirm do
        click_on "Destroy", match: :first
      end

      assert_text "Question was successfully destroyed"
    end
  end
end
