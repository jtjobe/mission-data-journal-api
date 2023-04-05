# TODO: add missing CRUD actions (C,U,D), error handling, authentication, etc...

module V1
  class EntriesController < V1::BaseController

    def index
      render json: { entries: Entry.all_for_journal(params[:journal_id]) }
    end

    def show
      @entry = Entry.find(safe_params[:id])
      render json: { entry: @entry }
    end

    def safe_params
      params.permit(:id, :journal_id)
    end
  end
end
