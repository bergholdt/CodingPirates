class EntriesController < ApplicationController
  def index
    @entry = Entry.new
    @entries = Entry.order(id: :desc).limit(50)
  end

  def create
    @entry = Entry.new(entry_params)
    if @entry.save
      redirect_to entries_path, notice: "Dit eventyr er gemt!", status: :see_other
    else
      @entries = Entry.order(id: :desc).limit(50)
      render :index, status: :unprocessable_entity
    end
  end

  private

  def entry_params
    params.require(:entry).permit(:pirat, :tekst)
  end
end
