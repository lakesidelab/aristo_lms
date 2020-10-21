require 'test_helper'

module AristoLms
  class TrainingTest < ActiveSupport::TestCase

    setup do
      @routes = Engine.routes
      @training = aristo_lms_trainings(:one)
      @content = aristo_lms_trainings(:content)
    end

    test "the truth" do
      assert true
    end

    test "should not insert without name" do
      training = Training.new(name: nil, description: @training.description, category: @training.category,
                  content: @training.content, position: @training.position, sort_order: @training.sort_order,
                  user_id: @training.user_id)
      assert_not training.save, "Saved training without name"
    end

    test "should insert with name as training" do
      training = Training.new(name: @content.name, description: @content.description, category: @content.category,
                  content: @content.content, position: @content.position, sort_order: @content.sort_order,
                  user_id: @content.user_id)
      assert training.save
    end

    test "should create content" do
      training = Training.new(name: @content.name, description: @training.description, category: @training.category,
                  content: @training.content, position: @training.position, sort_order: @training.sort_order,
                  user_id: @training.user_id)
      assert training.save
    end

  end
end
