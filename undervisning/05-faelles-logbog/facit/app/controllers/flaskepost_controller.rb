class FlaskepostController < ApplicationController
  def new
    @pirat = ""
    @tekst = ""
  end

  def create
    @pirat = params[:pirat].to_s.strip
    @tekst = params[:tekst].to_s.strip
    if @pirat.length.between?(1, 24) && @tekst.length.between?(1, 280)
      render :vis
    else
      @fejl = "Skriv et piratnavn på 1-24 tegn og et eventyr på 1-280 tegn."
      render :new, status: :unprocessable_entity
    end
  end
end
