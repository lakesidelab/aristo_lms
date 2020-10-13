require_dependency "aristo_lms/application_controller"

module AristoLms
  class ContentsController < ApplicationController
    before_action :get_training
    before_action :set_content, only: [:show, :edit, :update, :destroy]

    # GET /contents
    def index
      @contents = @training.contents
    end

    # GET /contents/1
    def show
    end

    # GET /contents/new
    def new
      @content = @training.contents.build
    end

    # GET /contents/1/edit
    def edit
    end

    # POST /contents
    def create
      @content = @training.contents.build(content_params)

      if @content.save
        redirect_to training_content_path(@content), notice: 'Content was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /contents/1
    def update
      if @content.update(content_params)
        redirect_to training_content_path(@content), notice: 'Content was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /contents/1
    def destroy
      @content.destroy
      redirect_to training_posts_path, notice: 'Content was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def get_training
        @training = Training.find(params[:training_id])
      end

      def set_content
        @content = @training.contents.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def content_params
        params.require(:content).permit(:name, :content)
      end
  end
end
