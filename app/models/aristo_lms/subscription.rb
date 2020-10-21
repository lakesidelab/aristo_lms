module AristoLms
  class Subscription < ApplicationRecord
    belongs_to :training
    belongs_to :user, class_name: AristoLms.user_class
    has_many :statuses
    has_many :attempts
    validates_presence_of [:training_id, :user_id]
  end
end
