require "webpacker/helper"

module AristoLms
  module ApplicationHelper
    include ::Webpacker::Helper

    def current_webpacker_instance
      AristoLms.webpacker
    end
  end
end
