module AristoLms
  class Training < ApplicationRecord
    # before_validation :set_user

    # acts_as_list
    has_closure_tree order: 'sort_order', numeric_order: true, dependent: :destroy
    has_many :questions
    belongs_to :user, class_name: AristoLms.user_class
    has_many :subscriptions, dependent: :destroy
    has_many :users, class_name: AristoLms.user_class, through: :subscriptions
    has_rich_text :content
    has_one_attached :cover_image
    validates_presence_of :name

    def set_user
      self.user = AristoLms.user_class.constantize.find(user_id)
    end


    # def self.user_class
    #   @@user_class.constantize
    # end

  end
end
