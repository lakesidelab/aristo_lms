require_dependency "aristo_lms/application_controller"

module AristoLms
  class TrainingsController < ApplicationController

    before_action :set_training, only: [:show, :edit, :update, :destroy]
    before_action :user_existing

    # GET /trainings
    def index
      @trainings = Training.where(parent_id: nil).order(position: :asc)
    end

    def sort
      params[:training].each_with_index do |id, index|
        Training.where(id: id).update_all(position: index + 1)
      end

      head :ok
    end

    def sort_children
      params[:training].each_with_index do |id, index|
        Training.where(id: id).update_all(sort_order: index)
      end
    end

    # GET /trainings/1
    def show
      @current_user = current_user
      @is_arisro_admin = is_aristo_admin
      @modules = @training.children
    end

    def start_module
      @training = Training.find(params[:training_id])
      @status = Status.new(user_id: current_user.id, training_id: @training.id, immediate_parent_id: @training.parent.id || @training.parent ,
        root_id: @training.ancestors.last.id || @training.ancestors.last )
      if @status.save
        redirect_to training_path(@training)
      else
        redirect_to subscriptions_path
      end
    end

    # GET /trainings/new
    def new
      @parent_id = params[:parent_id]
      @category = params[:category]
      if @category == "question"
        @label = "question"
        @detail = "More details if any"
      end

      if @category == "option"
        @label = "option"
        @detail = "More information on why it is wright or wrong"
      end
      if !(@parent_id.nil?)
        @parent = Training.find(@parent_id)
      end
      @training = Training.new
    end

    # GET /trainings/1/edit
    def edit
    end

    # POST /trainings
    def create
      @training = Training.new(training_params)
      @training.user_id = current_user.id
      if @training.save
        redirect_to @training, notice: 'Training was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /trainings/1
    def update
      if @training.update(training_params)
        redirect_to @training, notice: 'Training was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /trainings/1
    def destroy
      @training.destroy
      redirect_to trainings_url, notice: 'Training was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_training
        @training = Training.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def training_params
        params.require(:training).permit(:name, :description, :parent_id, :category, :content, :correct)
      end


      def user_existing
        if !(is_aristo_admin)
          redirect_to subscriptions_path, alert: "You are not allowed to do that"
        end
      end

  end
end
