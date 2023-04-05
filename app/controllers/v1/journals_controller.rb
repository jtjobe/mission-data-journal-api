# TODO: params whitelisting, authentication, error handling...

module V1
  class JournalsController < V1::BaseController

    before_action :load_journal, only: [:show, :update, :destroy]

    def index
      render json: { journals: Journal.all }
    end

    def create
      if safe_params[:name].present?
        new_journal = Journal.create(safe_params)
        render json: { journal: new_journal }
      else
        render json: { error: 'You must provide a name for the Journal' }
      end
    end

    def show
      @journal = Journal.find(safe_params[:id])
      render json: { journal: @journal }
    end

    def update
      @journal.update(safe_params)
      render json: { journal: @journal }
    end

    def destroy
      @journal.destroy
      render json: { deleted_journal: @journal }
    end

    private

    def load_journal
      @journal = Journal.find(safe_params[:id])
    end

    def safe_params
      params.permit(:name, :id)
    end
  end
end
