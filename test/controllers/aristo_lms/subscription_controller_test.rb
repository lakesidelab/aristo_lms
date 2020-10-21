require 'test_helper'

module AristoLms
  class SubscriptionControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @subscription = aristo_lms_subscriptions(:one)
    end

    test "should get index with session" do
      sign_in('test@mail.com', 'password')
      get aristo_lms.subscriptions_url
      assert_response :success
    end

    private
    def sign_in(email, password)
      post login_url, params: { email: email, password: password }
    end
  end
end
