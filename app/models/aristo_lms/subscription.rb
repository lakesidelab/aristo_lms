module AristoLms
  class Subscription < ApplicationRecord
    belongs_to :training
    belongs_to :user, class_name: AristoLms.user_class
    has_many :statuses
  end
end
