module AristoLms
  class Answer < ApplicationRecord
    validates_presence_of [:user_id, :attempt_id]
  end
end
