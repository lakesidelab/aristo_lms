class User < ApplicationRecord

  has_many :aristo_lms_trainings, class_name: 'AristoLms::Training', foreign_key: :user_id

  has_many :aristo_lms_subscriptions, class_name: 'AristoLms::Subscription', foreign_key: :user_id
  has_many :aristo_lms_trainings, through: :aristo_lms_subscriptions

end
