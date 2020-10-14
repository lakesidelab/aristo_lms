require_dependency "aristo_lms/application_controller"

module AristoLms
  class SubscriptionsController < ApplicationController
    before_action :set_current_user, only: [:index, :new]
    before_action :set_subscription, only: [:show]

    def index
      @subscriptions = Subscription.where(user_id: current_user.id)
    end

    def new
      @trainings = Training.where(parent_id: nil)
    end


    def create
      @subscription = Subscription.create(training_id: params[:training_id], user_id: current_user.id )
      if @subscription.save
        redirect_to subscriptions_path
      else
        redirect_to new_subscriptions_path, alert: "Not added"
      end
    end


    def finish
      Status.where(subscription_id: params[:subscription_id], user_id: current_user.id).update(completed: true)
      redirect_to subscriptions_path
    end

    def quiz
      # render plain: params.inspect
      @answer = Answer.
                  find_or_initialize_by(answer_params).
                  update_attributes!(answer_id: params[:answer][:answer_id])
      @subscription = Subscription.find(params[:answer][:subscription_id])
      @active_module = Training.find(params[:answer][:module_id])
      @immediate_parent = Training.find(params[:answer][:session_id])
      @active_node = Training.find(params[:answer][:question_id])
      if @immediate_parent.category != "question_answer_session"
        @to_be_set = @active_node
      else
        @to_be_set = @active_module
      end
      if @answer
        @correct_answer = @active_node.children.where(correct: "yes")

        if @correct_answer.length == 1 && params[:answer][:answer_id].to_i == @correct_answer[0].id
          if Mark.where(training_id: @active_node.id, user_id: current_user.id).length != 0 && !(Mark.where(training_id: @active_node.id, user_id: current_user.id)[0].marks.nil?)
            puts(Mark.where(["training_id = ? and user_id = ?", "#{@active_node.id}", "#{current_user.id}"])[0].attributes)
            @obtained_marks = Mark.where(training_id: @active_node.id, user_id: current_user.id)[0].marks + 1
          else
            @obtained_marks = 1
          end
        elsif @correct_answer.length != 1 && params[:answer][:answer_id] - @active_node.children.where(correct: "yes").map{|child| child.id.to_s} == []
          if Mark.where(training_id: @active_node.id, user_id: current_user.id).length != 0
            @obtained_marks = Mark.where(training_id: @active_node.id, user_id: current_user.id)[0].marks + 1
          else
            @obtained_marks = 1
          end
        end
        if @immediate_parent.category == "question_answer_session" && @active_node.siblings_after.length!= 0
          redirect_to subscription_path(@subscription, active_module_id: @active_module, immediate_parent_id: @immediate_parent, active_node_id: @active_node.siblings_after.first)
        else
          if @to_be_set.category == "question"
            @mark = Mark
                      .find_or_initialize_by(user_id: current_user.id, training_id: @to_be_set.id)
                      .update_attributes!(marks: @obtained_marks)
            redirect_to subscription_path(@subscription, active_module_id: @active_module, immediate_parent_id: @to_be_set.parent, active_node_id: @to_be_set, finished: true)
          else
            @active_node = @active_node.parent
            @mark = Mark
            .find_or_initialize_by(user_id: current_user.id, training_id: @active_node.id)
            .update_attributes!(marks: @obtained_marks)
            redirect_to subscription_path(@subscription, active_module_id: @active_module, immediate_parent_id: @active_node.parent, active_node_id: @active_node, finished: true)
          end
        end
      end
    end


    def show
      @active_module_id = params[:active_module_id]
      @active_node_id  = params[:active_node_id]
      @immediate_parent_id = params[:immediate_parent_id]

      if params[:active_module_id].nil?
        @active_module = @subscription.training.children.first
        @immediate_parent = @subscription.training.children.first
        @active_node  = @active_module.children.first
      else
        @active_module = Training.find(params[:active_module_id])
        @active_node  = Training.find(params[:active_node_id])
        @immediate_parent = Training.find(params[:immediate_parent_id])
      end

      if @active_node.category == "question" && @active_node.children
        if params[:retake] && @active_node.parent.category == "question_answer_session"
          Mark.where(["training_id = ? and user_id = ?", "#{@active_node.parent.id}", "#{current_user.id}"]).update(marks: nil)
        elsif params[:retake] && @active_node.parent.category != "question_answer_session"
          Mark.where(["training_id = ? and user_id = ?", "#{@active_node.id}", "#{current_user.id}"]).destroy_all
        end
        @answer = Answer.new
        if @active_node.children.where(correct: "yes").length > 1
          @mcq = true
        end
      end

      if @active_node.category == "question_answer_session" || @active_node.category == "question"
        if Mark.where(["training_id = ? and user_id = ?", "#{@active_node.id}", "#{current_user.id}"]).length != 0
          @already_done = true
        end
        if params[:finished]
          @finished = true
        end
      end

      if !(@finished)
        Status.
          find_or_initialize_by(subscription_id: @subscription.id, active_module_id: @active_module.id, user_id: current_user.id)
          .update_attributes!(immediate_parent_id: @immediate_parent.id, active_node_id: @active_node.id)
      end

    end

    private

    def subscription_params
      params.require(:subscription).permit(:training_id, :user_id)
    end

    def answer_params
      params.require(:answer).permit(:session_id, :answer_id, :question_id, :module_id, :subscription_id)
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
