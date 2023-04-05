# TODO: params whitelisting, authentication, error handling...

module V1
  class JournalsController < V1::BaseController

    before_action :load_journal, only: [:show, :update, :destroy]

    def index
      render json: { journals: Journal.all }
    end

    def create
      new_journal = Journal.create(safe_params)
      render json: { journal: new_journal }
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
