require "aristo_lms/engine"
require "webpacker"
require "closure_tree"
require "jquery-rails"
require "acts_as_list"
require "jquery-ui-rails"
require "turbolinks"
require "bootstrap-sass"
require "slim-rails"

module AristoLms

  mattr_accessor :user_class

  ROOT_PATH = Pathname.new(File.join(__dir__, ".."))

  class << self
    def webpacker
      @webpacker ||= ::Webpacker::Instance.new(
        root_path: ROOT_PATH,
        config_path: ROOT_PATH.join("config/webpacker.yml")
      )
    end
  end
end
