require 'test_helper'

module AristoLms
  class AttemptTest < ActiveSupport::TestCase

    setup do
      @attempt = aristo_lms_attempts(:one)
    end

    test "the truth" do
      assert true
    end

    test "should not insert without user id" do
      attempt = Attempt.new(user_id: nil, subscription_id: @attempt.subscription_id, current_node_id: @attempt.current_node_id,
                            total_question: @attempt.total_question, score: @attempt.score, result: @attempt.result)
      assert_not attempt.save, "Saved without user id"
    end


    test "should not insert without subscription id" do
      attempt = Attempt.new(user_id: @attempt.user_id, subscription_id: nil, current_node_id: @attempt.current_node_id,
                            total_question: @attempt.total_question, score: @attempt.score, result: @attempt.result)
      assert_not attempt.save, "Saved without subscription id"
    end

    test "should not insert without current node id" do
      attempt = Attempt.new(user_id: @attempt.user_id, subscription_id: @attempt.subscription_id, current_node_id: nil,
                            total_question: @attempt.total_question, score: @attempt.score, result: @attempt.result)
      assert_not attempt.save, "Saved without current node id"
    end


  end
end
