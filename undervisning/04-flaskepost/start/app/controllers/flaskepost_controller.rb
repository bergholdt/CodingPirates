class FlaskepostController < ApplicationController
  def new
    @pirat = ""
    @tekst = ""
  end

  def create
    @pirat = "" # TRIN 1: Læs params[:pirat].
    @tekst = "" # TRIN 1: Læs params[:tekst].
    if @pirat.length.between?(1, 24) && @tekst.length.between?(1, 280)
      render :vis
    else
      @fejl = "Skriv et piratnavn på 1-24 tegn og et eventyr på 1-280 tegn."
      render :new, status: :unprocessable_entity
    end
  end
end
