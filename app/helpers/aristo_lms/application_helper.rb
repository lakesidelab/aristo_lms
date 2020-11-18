require "webpacker/helper"

module AristoLms
  module ApplicationHelper
    include ::Webpacker::Helper

    def current_webpacker_instance
      AristoLms.webpacker
    end

    def method_missing method, *args, &block
      if method.to_s.end_with?('_path') or method.to_s.end_with?('_url')
        if main_app.respond_to?(method)
          main_app.send(method, *args)
        else
          super
        end
      else
        super
      end
    end

  end
end
