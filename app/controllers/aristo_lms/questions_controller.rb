require_dependency "aristo_lms/application_controller"

module AristoLms
  class QuestionsController < ApplicationController
    before_action :get_training
    before_action :set_question, only: [:show, :edit, :update, :destroy]

    # GET /questions
    def index
      @questions = @training.questions
    end

    # GET /questions/1
    def show
    end

    # GET /questions/new
    def new
      @question = @training.questions.build
      3.times do
        option = @question.options.build
      end
    end

    # GET /questions/1/edit
    def edit
    end

    # POST /questions
    def create
      @question = @training.questions.build(question_params)

      if @question.save
        redirect_to training_path(@training), notice: 'Question was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /questions/1
    def update
      if @question.update(question_params)
        redirect_to training_question_path(@training), notice: 'Question was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /questions/1
    def destroy
      @question.destroy
      redirect_to training_questions_path(@training), notice: 'Question was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_question
        @question = @training.questions.find(params[:id])
      end

      def get_training
        @training = Training.find(params[:training_id])
      end

      # Only allow a trusted parameter "white list" through.
      def question_params
        params.require(:question).permit(:question_text, options_attributes: [:option_text, :is_correct])
      end
  end
end
