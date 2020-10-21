require 'test_helper'

module AristoLms
  class SubscriptionTest < ActiveSupport::TestCase

    setup do
      @subscription = aristo_lms_subscriptions(:two)
    end

    test "should not insert without training id" do
      subscription = Subscription.new(training_id: nil, user_id: @subscription.user_id)
      assert_not subscription.save, "Saving witout training id"
    end

    test "should not insert without user id" do
      subscription = Subscription.new(training_id: nil, user_id: @subscription.user_id)
      assert_not subscription.save, "Saving witout training id"
    end

    test "shoudl insert with training and user id" do
      subscription = Subscription.new(training_id: @subscription.id, user_id: @subscription.user_id)
      assert subscription.save
    end

  end
end
