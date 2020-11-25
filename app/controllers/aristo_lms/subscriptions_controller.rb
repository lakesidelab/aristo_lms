# require_dependency "aristo_lms/application_controller"

module AristoLms
  class SubscriptionsController < ApplicationController
    before_action :set_current_user, only: [:index, :new]
    before_action :set_subscription, only: [:show, :start]

    def index
      @subscriptions = Subscription.where(user_id: current_user.id)
    end

    def new
      @trainings = Training.where(parent_id: nil)
    end


    def create
      @subscription = Subscription.create(training_id: params[:training_id], user_id: current_user.id )
      if @subscription.save
        redirect_to helpers.switch_subscriptions
      else
        redirect_to new_subscription_path, alert: "Not added"
      end
    end


    def finish
      @attempt = Attempt.where(subscription_id: params[:subscription_id], user_id: current_user.id).order(:created_at).last
      if @attempt.total_question == 0
        @attempt.result = "pass"
      elsif @attempt.total_question !=0 && @attempt.score == 0
        @attempt.result = "fail"
      elsif @attempt.score != 0 && @attempt.score / @attempt.total_question * 100 >= 50
        @attempt.result = "pass"
      else
        @attempt.result = "fail"
      end
      @attempt.update(completed: true)
      redirect_to helpers.switch_subscriptions
    end

    def quiz
      # render plain: params.inspect

      if !(params[:answer][:multiple_answer_ids].nil?)
        @answer = Answer.new(user_id: current_user.id, question_id: params[:answer][:question_id],
                    multiple_answer_ids: params[:answer][:multiple_answer_ids].join(","), attempt_id: params[:answer][:attempt_id])
      else
        @answer = Answer.new(user_id: current_user.id, question_id: params[:answer][:question_id],
          answer_id: params[:answer][:answer_id], attempt_id: params[:answer][:attempt_id])
      end

      @answer.save

      @siblings_after = Training.find(params[:answer][:question_id]).siblings_after
      @subscription = Subscription.find(params[:answer][:subscription_id])
      @active_module = Training.find(params[:answer][:module_id])


      @question = Training.find(params[:answer][:question_id])
      if @question.children.where(correct: "yes").length == 1
        if @question.children.where(correct: "yes").first.id  == params[:answer][:answer_id].to_i
          @attempt = Attempt.where(subscription_id: params[:answer][:subscription_id], user_id: current_user.id).order(:created_at).last

          @attempt.increment!(:score)
        end
      else
        @right_answer_ids = @question.children.where(correct: "yes").map{|object| object.id.to_s }
        puts(@right_answer_ids)
        if !(@right_answer_ids.difference(params[:answer][:multiple_answer_ids]).any?)
          @attempt = Attempt.where(subscription_id: params[:answer][:subscription_id], user_id: current_user.id).last

          @attempt.increment!(:score)
        end
      end



      if @siblings_after.length != 0
        @active_node = @siblings_after.first
        redirect_to subscription_path(@subscription, active_module_id: @active_module, immediate_parent: @active_node.parent, active_node_id: @active_node)
      else
        @active_node = Training.find(params[:answer][:question_id])
        redirect_to finish_track_path(subscription_id: @subscription)
      end
    end

    def start
      @active_node = @subscription.training.children.first
      @attempt = Attempt.new(user_id: current_user.id, subscription_id: @subscription.id, current_node_id: @active_node.id,
                              total_question: 0)
      @attempt.save
      redirect_to subscription_path(@subscription, active_node_id: @active_node.id)
    end

    def show
      @active_module_id = params[:active_module_id]
      @active_node_id  = params[:active_node_id]
      @immediate_parent_id = params[:immediate_parent_id]

      @attempt = Attempt.where(user_id: current_user.id, subscription_id: @subscription.id).order(:created_at).last

      # @active_node = @subscription.training.children.first
      # @attempt = Attempt.new(user_id: current_user.id, subscription_id: @subscription.id, current_node_id: @active_node.id,
      #                         total_question: 0)
      # @attempt.save

      if params[:active_node_id].nil?
        @active_node  = @subscription.training
        @immediate_parent = @subscription.training
      else
        @active_node  = Training.find(params[:active_node_id])
        @active_module = @active_node.ancestors[@active_node.ancestors.length - 2]
        @immediate_parent = @active_node.parent
        @attempt.update(current_node_id: @active_node.id)
      end

      if @active_node.category == "module"
        @finished = params[:finished_module] ? params[:finished_module] : false
      end

      if @active_node.category == "switch" && !(params[:finished_module_id].nil?)
        @training_id = Training.find(params[:finished_module_id]).id
        @switch = Switch.new(attempt_id: @@attempt.id, training_id: params[:finished_module_id], completed: true)
        @switch.save
      end


      if @active_node.category == "question"
        @attempt.increment!(:total_question)
        @answer = Answer.new
        if @active_node.children.where(correct: "yes").length > 1
          @mcq = true
        end
      end


    end

    private

    def subscription_params
      params.require(:subscription).permit(:training_id, :user_id)
    end

    def answer_params
      params.require(:answer).permit(:attempt_id, :question_id, :answer_id, :subscription_id, :module_id)
    end

    def attempt_params
      params.require(:attempt).permit(:user_id, :subscription_id, :current_node_id, :total_question, :score,
                                      :completed, :result)
    end

    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

    def set_current_user
      if !current_user
        redirect_to main_app.root_path, alert: "Please Sign in to view your subscriptions"
      end
    end
  end
end
