module AristoLms
  class Attempt < ApplicationRecord
    belongs_to :subscription
    has_many :answers
    has_many :switches

    validates_presence_of [:user_id, :subscription_id, :current_node_id]
  end
end
