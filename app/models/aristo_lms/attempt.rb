module AristoLms
  class Attempt < ApplicationRecord
    belongs_to :subscription
    has_many :answers    
  end
end
