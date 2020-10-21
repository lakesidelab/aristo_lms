require 'test_helper'

module AristoLms
  class TrainingsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @training = aristo_lms_trainings(:one)
      @child = aristo_lms_trainings(:two)
    end

    test "should not get index without session" do
      get trainings_url
      assert_redirected_to subscriptions_url
    end

    test "should not get index without admin" do
      sign_in('test@mail.com', 'password')
      get aristo_lms.trainings_url
      assert_redirected_to subscriptions_url
    end

    test "should get index with session admin access" do
      sign_in('admin@mail.com', 'password')
      get aristo_lms.trainings_url
      assert_response :success
    end

    test "should not get new without session" do
      get new_training_url
      assert_redirected_to subscriptions_url
    end

    test "should not get new without admin access" do
      sign_in('test@mail.com', 'password')
      get aristo_lms.new_training_url
      assert_redirected_to subscriptions_url
    end


    test "should get new with session and admin access" do
      sign_in('admin@mail.com', 'password')
      get aristo_lms.new_training_url
      assert_response :success
    end

    test "should create root training" do
      sign_in('admin@mail.com', 'password')
      assert_difference('Training.count') do
        post aristo_lms.trainings_url, params: { training: { name: @training.name, description: @training.description, parent_id:
          @training.parent_id, category: @training.category, content: @training.content, position: @training.position,
          sort_order: @training.sort_order, user_id: @training.user_id } }
      end

      assert_redirected_to training_url(Training.last)
    end

    test "should create child training" do
      sign_in('admin@mail.com', 'password')
      assert_difference('Training.count') do
        post aristo_lms.trainings_url, params: { training: { name: @child.name, description: @child.description, parent_id:
          @child.parent_id, category: @child.category, content: @child.content, position: @child.position,
          sort_order: @child.sort_order, user_id: @child.user_id } }
      end
    end

    #
    # test "should create training" do
    #   assert_difference('Training.count') do
    #     post trainings_url, params: { training: { description: @training.description, name: @training.name } }
    #   end
    #
    #   assert_redirected_to training_url(Training.last)
    # end

    test "should show training" do
      sign_in('admin@mail.com', 'password')
      get aristo_lms.training_url(@training)
      assert_response :success
    end

    test "should get edit" do
      sign_in('admin@mail.com', 'password')
      get aristo_lms.edit_training_url(@training)
      assert_response :success
    end

    test "should update training" do
      sign_in('admin@mail.com', 'password')
      patch aristo_lms.training_url(@training), params: { training: { description: @training.description, name: @training.name } }
      assert_redirected_to training_url(@training)
    end

    #
    #
    test "should destroy training" do
      sign_in('admin@mail.com', 'password')
      assert_difference('Training.count', -1) do
        delete aristo_lms.training_url(@training)
      end

      assert_redirected_to trainings_url
    end


    private
    def sign_in(email, password)
      post login_url, params: { email: email, password: password }
    end
  end
end
