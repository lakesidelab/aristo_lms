require_dependency "aristo_lms/application_controller"

module AristoLms
  class OptionsController < ApplicationController
    before_action :set_option, only: [:show, :edit, :update, :destroy]
    before_action :get_training
    before_action :get_question

    # GET /options
    def index
      @options = Option.all
    end

    # GET /options/1
    def show
    end

    # GET /options/new
    def new
      @option = @question.options.build
    end

    # GET /options/1/edit
    def edit
    end

    # POST /options
    def create
      @option = Option.new(option_params)

      if @option.save
        redirect_to training_path(@training), notice: 'Option was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /options/1
    def update
      if @option.update(option_params)
        redirect_to training_path(@training), notice: 'Option was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /options/1
    def destroy
      @option.destroy
      redirect_to training_path(@training), notice: 'Option was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_option
        @option = Option.find(params[:id])
      end

      def get_question
        @question = Question.find(params[:question_id])
      end

      def get_training
        @training = Training.find(params[:training_id])
      end

      # Only allow a trusted parameter "white list" through.
      def option_params
        params.require(:option).permit(:option_text, :question_id)
      end
  end
end
