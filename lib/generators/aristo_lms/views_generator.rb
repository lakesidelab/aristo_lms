require 'rails/generators/base'

module AristoLms
  module Generators
    class ViewsGenerator < Rails::Generators::Base

      source_root File.expand_path("../../../../app/views/aristo_lms", __FILE__)

      argument :scope, required: false, default: nil,
                         desc: "The scope to copy views to"

      def copy_views
        view_directory :subscriptions
        view_directory :trainings
      end

      protected

      def view_directory(name, _target_path = nil)
        directory name.to_s, _target_path || "#{target_path}/aristo_lms/#{name}" do |content|
          content
        end
      end

      def target_path
        @target_path ||= "app/views/#{plural_scope}"
      end

      def plural_scope
        @plural_scope ||= scope.presence && scope.underscore.pluralize
      end
    end
  end
end
