require 'test_helper'

module AristoLms
  class OptionsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @option = aristo_lms_options(:one)
    end

    test "should get index" do
      get options_url
      assert_response :success
    end

    test "should get new" do
      get new_option_url
      assert_response :success
    end

    test "should create option" do
      assert_difference('Option.count') do
        post options_url, params: { option: { option_text: @option.option_text, question_id: @option.question_id } }
      end

      assert_redirected_to option_url(Option.last)
    end

    test "should show option" do
      get option_url(@option)
      assert_response :success
    end

    test "should get edit" do
      get edit_option_url(@option)
      assert_response :success
    end

    test "should update option" do
      patch option_url(@option), params: { option: { option_text: @option.option_text, question_id: @option.question_id } }
      assert_redirected_to option_url(@option)
    end

    test "should destroy option" do
      assert_difference('Option.count', -1) do
        delete option_url(@option)
      end

      assert_redirected_to options_url
    end
  end
end
