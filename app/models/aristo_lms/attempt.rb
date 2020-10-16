module AristoLms
  class Attempt < ApplicationRecord
    belongs_to :subscription
    has_many :answers
    has_many :switches 
  end
end
