class VijestiController < ApplicationController
  before_filter :authenticate   

  def index
  end

  def show
    render layout: nil
  end
end
