module AristoLms
  class Mark < ApplicationRecord
    validates_presence_of [:training_id, :user_id]
  end
end
