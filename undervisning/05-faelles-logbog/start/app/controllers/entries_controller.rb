class EntriesController < ApplicationController
  def index
    @entry = Entry.new
    @entries = [] # TRIN 1: Hent indlæggene fra databasen.
  end

  def create
    @entry = Entry.new(entry_params)
    if false # TRIN 2: Gem modellen med @entry.save
      redirect_to entries_path, notice: "Dit eventyr er gemt!", status: :see_other
    else
      @entries = [] # TRIN 1: Hent indlæggene fra databasen.
      render :index, status: :unprocessable_entity
    end
  end

  private

  def entry_params
    params.require(:entry).permit(:pirat, :tekst)
  end
end
