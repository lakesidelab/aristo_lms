module AristoLms
  class Engine < ::Rails::Engine
    require 'jquery-ui-rails'
    
    isolate_namespace AristoLms


    initializer "aristo_lms.assets.precompile" do |app|
      app.config.assets.precompile += %w( aristo_lms/application.css aristo_lms/plus.png )
    end

    config.app_middleware.use(
      Rack::Static,
      urls: ["/aristo-lms-packs"], root: AristoLms::Engine.root.join("public")
      # urls: ["/aristo-lms-packs"], root: "../../public"
    )

    initializer "webpacker.proxy" do |app|
        insert_middleware = begin
                            AristoLms.webpacker.config.dev_server.present?
                          rescue
                            nil
                          end
        next unless insert_middleware

        app.middleware.insert_before(
          0, Webpacker::DevServerProxy, # "Webpacker::DevServerProxy" if Rails version < 5
          ssl_verify_none: true,
          webpacker: AristoLms.webpacker
        )
    end
  end
end
