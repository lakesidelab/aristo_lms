module AristoLms
  class ApplicationController < ::ApplicationController
    layout AristoLms.layout || 'application'
    protect_from_forgery with: :exception
  end
end
